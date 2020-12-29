# README

## TODO

* authenticate admins in the clock events controller
* allow users to delete their own events (but not edit) - require confirmation
* create seed users
* test on heroku

### For the list of all clock events:
* Default view shows events grouped by user
* collect all events by day
* count the hours worked each day
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
- in/out
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

**index clock in/out events**
  - sort by time (most recent first)
  - group by user - show multiple columns with total per day in final column
  - filter by user
  - allow deletion/editing
  - *can only be accessed by admin user*


### What schema design did you choose and why?
The User model allows us to keep track of who is clocking in and out, provides us some validation

The Role model lets us offer greater access to certain employees, while not allowing other employees that access

The ClockEvent model lets us keep track of events, with enough information to query, sort, and filter as needed

### If you were given another day to work on this, how would you spend it?

### What if you were given a month?
* an api and a phone app so employees can clock in/out more easily
* ability for admin to send a message to all employees to notify of a free half-day early holiday or something
* warning to admin if employees clock in at strange hours or fail to fulfill a minimum hours per week
