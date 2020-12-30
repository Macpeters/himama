# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Role.destroy_all
UserRole.destroy_all
ClockEvent.destroy_all

admin_user = User.create!(
  name: 'Admin User',
  email: 'admin@email.com',
  password: '123abc'
)
admin_role = Role.create(
  role_type: 'admin'
)
UserRole.create(role: admin_role, user: admin_user)
puts "Created Admin User: #{admin_user.id}"

(0..10).to_a.each do |index|
  clock_in_event = ClockEvent.create!(
    user: admin_user,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now - index.days
  )

  clock_out_event = ClockEvent.create!(
    user: admin_user,
    clock_in: false,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now + 4.hours - index.days,
    hours_clocked: 4,
    clock_in_id: clock_in_event.id
  )

  clock_in_event.update(clock_out_id: clock_out_event.id)
  puts "Created ClockEvents for Admin User: #{index}"
end


test_user_1 = User.create!(
  name: 'Test User1',
  email: 'testuser1@email.com',
  password: '123abc'
)
puts "Created Test User: #{test_user_1.id}"

(0..5).to_a.each do |index|
  hour_difference = 6
  clock_in_event = ClockEvent.create!(
    user: test_user_1,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now - index.days
  )

  clock_out_event = ClockEvent.create!(
    user: test_user_1,
    clock_in: false,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now + hour_difference.hours - index.days,
    hours_clocked: hour_difference,
    clock_in_id: clock_in_event.id
  )
  puts "Created Clock Events for TestUser1: #{index}"

  # multiple Clock in/outs per day
  clock_in_event_2 = ClockEvent.create!(
    user: test_user_1,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days + 2.hours,
    occurred_at_time: Time.zone.now - index.days + 2.hours
  )

  clock_out_event_2 = ClockEvent.create!(
    user: test_user_1,
    clock_in: false,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days + 4.hours,
    occurred_at_time: Time.zone.now + 6.hours - index.days + 4.hours,
    hours_clocked: 2,
    clock_in_id: clock_in_event.id
  )

  clock_in_event_2.update(clock_out_id: clock_out_event_2.id)
  puts "Created MORE Clock Events for TestUser1: #{index}"
end

clock_in_event = ClockEvent.create!(
  user: test_user_1,
  clock_in: true,
  occurred_at_date: Time.zone.now.beginning_of_day + 6.hours,
  occurred_at_time: Time.zone.now
)
puts "Created Single Clock in Event for TestUser1"


test_user_2 = User.create!(
  name: 'Test User2',
  email: 'testuser2@email.com',
  password: '123abc'
)
puts "Created Test User: #{test_user_2.id}"

(3..14).to_a.each do |index|
  hour_difference = 1
  clock_in_event = ClockEvent.create!(
    user: test_user_2,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now - index.days
  )

  clock_out_event = ClockEvent.create!(
    user: test_user_2,
    clock_in: false,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now + hour_difference.hour - index.days,
    hours_clocked: hour_difference,
    clock_in_id: clock_in_event.id
  )

  clock_in_event.update(clock_out_id: clock_out_event.id)
  puts "Created Clock Events for TestUser2: #{index}"
end


test_user_3 = User.create!(
  name: 'Test User3',
  email: 'testuser3@email.com',
  password: '123abc'
)
puts "Created Test User: #{test_user_3.id}"

(2..7).to_a.each do |index|
  hour_difference = 3
  clock_in_event = ClockEvent.create!(
    user: test_user_3,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now - index.days
  )

  clock_out_event = ClockEvent.create!(
    user: test_user_3,
    clock_in: false,
    occurred_at_date: Time.zone.now.beginning_of_day - index.days,
    occurred_at_time: Time.zone.now + hour_difference.hours - index.days,
    hours_clocked: hour_difference,
    clock_in_id: clock_in_event.id
  )

  clock_in_event.update(clock_out_id: clock_out_event.id)
  puts "Created Clock Events for TestUser3: #{index}"
end

clock_in_event = ClockEvent.create!(
  user: test_user_3,
  clock_in: true,
  occurred_at_date: Time.zone.now.beginning_of_day,
  occurred_at_time: Time.zone.now
)
puts "Created Single Clock in Event for TestUser3: #{clock_in_event}"




