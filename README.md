# README
[On Heroku](https://damp-sands-38141.herokuapp.com/)
* need to migrate using heroku console
* need to add a role to admin user

## TODO
* create seed users
* allow events to be edited and/or deleted - require confirmation before delete

## Questions

### How did you approach this challenge?
I started with Rails 6, but backtracked to 5 because webpacker is default and not well enough documented currently - I didn't want to lose any more time on that.

#### Models
**User**
- id
- name
- password
- *has_many user_roles*
- *Use devise to for access control/login*
- https://launchschool.com/blog/how-to-use-devise-in-rails-for-authentication

**Role**
- id
- role_type *(employee, admin)*

**ClockEvent**
- id
- user_id
- time/date
- clock_in: boolean
- matching clock_event id
- explanation (optional)


#### Screens
**home screen**
- if user is not logged in, show login form
- if user is logged in, show links as appropriate
  - clock in/out
  - index events as appropriate
  - logout

**clock in/out screen**
  - show clock in/out depending on whether user is clocked in/out
  - refresh when the action is complete
  - if clocked in, show time clocked in, total time clocked in today
  - if clocked out, show total time clocked in today
  - *accessable to any employee*

**ADMIN index clock in/out events**
  - sort by time (most recent first)
  - group by user - show multiple columns with total per day in final column
  - filter by user
  - allow deletion/editing
  - *can only be accessed by admin user*


### What schema design did you choose and why?
The User model allows us to keep track of who is clocking in and out, provides us some validation

The Role model lets us offer greater access to certain employees, while not allowing other employees that access

The ClockEvent model lets us keep track of events (whenever someone clocks in or out)
  - a date is stored without time to make querying easier when we want all events from a specific day.  I could truncate the datetime every time, but scaling that would be difficult.
  - Matching events: these let us ensure we can track events in a meaningful way and list them for users so that they can be understood.  It also makes it easier to control what events can be deleted (you can't delete the clock in event if you have a clock out event - that would give us bad data)
    - a clock_in event will receive a clock_out event id when one is created
    - a clock_out event gets the id of the matching clock_in event

### If you were given another day to work on this, how would you spend it?
* better authentication - we currently hide a link to anyone but admins, but that is only front-end authentication, and users could get past it.  I also lost time trying to get basic user authentication working with rspec controller tests.  Right now we can have one or the other, but not both.
* automatic clock out at end of day and/or warning on days where clock out didn't happen manually
* better sorting/filtering on the admin view - I started looking at ransack, but ran out of time to implement it.
* admin screen should show the total hours per user per day only once


### What if you were given a month?
* ability for admin to send a message to all employees to notify of a free half-day early holiday or something
* warning to admin if employees clock in at strange hours or fail to fulfill a minimum hours per week
