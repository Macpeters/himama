# README
[On Heroku](https://damp-sands-38141.herokuapp.com/)
* need to migrate using heroku console
* need to run seeds

## Questions

### How did you approach this challenge?
I started with Rails 6, but backtracked to 5 because webpacker is not well enough documented currently - I didn't want to lose too much time figuring it out.

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

#### Screens
**home screen**
- if user is not logged in, show login form
- if user is logged in, show links as appropriate
  - clock in/out
  - list events for today
  - logout

**clock in/out screen**
  - show clock in/out depending on whether user is clocked in/out
  - refresh when the action is complete
  - if clocked in, show time clocked in, total time clocked in today
  - if clocked out, show total time clocked in today
  - *accessable to any employee*

**ADMIN index clock in/out events**
  - sort by time (most recent first).  Show events by day, with other days listed as links
  - group by user - show multiple columns with total per day in final column
  - allow deletion/editing
  - *can only be accessed by admin user*

  **Default Devise Screens**
  - log in
  - change password

### What schema design did you choose and why?
The User model allows us to keep track of who is clocking in and out, provides us some validation

The Role model lets us offer greater access to certain employees, while not allowing other employees that access.  We could also allow functionality for non-employees - we would only need to add more roles/user_roles to keep track.

The ClockEvent model lets us keep track of events (whenever someone clocks in or out)
  - a date is stored without time to make querying easier when we want all events from a specific day.  I could truncate the datetime every time, but scaling that would be difficult.
  - Matching events: these let us ensure we can track events in a meaningful way and list them for users so that they can be understood.  It also makes it easier to control what events can be deleted (you can't delete the clock in event if you have a clock out event - that would give us bad data)
    - a clock_in event will receive a clock_out event id when one is created
    - a clock_out event gets the id of the matching clock_in event
    - editing a clock event keeps the other updated (hours clocked)

### If you were given another day to work on this, how would you spend it?
* better authentication - we currently hide a link to anyone but admins, but that is only front-end authentication, and users could get past it.  I also lost time trying to get basic user authentication working with rspec controller tests.  Right now we can have one or the other, but not both.  CanCan might be a better way to control access.
* improve the ui - use icons, a nicer date picker, etc
* admin screen should show the total hours per user per day only once, and not on a clock in/out event that hasn't been clocked out yet
* home screen should also show previous days - for at least a week, so employees can check their hours.
* validate that hours clocked is a positive number
* currently anyone can sign up and have employee access - we could lock it down so that an admin or someone has to validate that employee before they can have access (give them the employee role, and lock down home screen/clocking in/out until they have that role, and create an admin screen where admins can accept or refuse employee requests)

### What if you were given a month?
* ability for admin to send a message to all employees to notify of a free half-day early holiday or something
* automatic clock out at end of day and/or warning on days where clock out didn't happen manually
* warning to admin if employees clock in at strange hours or fail to fulfill a minimum hours per week
* better sorting/filtering on the admin view - I started looking at ransack, but ran out of time to implement it.
