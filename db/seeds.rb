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

def create_admin_user
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

  create_clock_events(0, 3, admin_user, 'Admin User', 4)
end

def create_test_user_1
  test_user_1 = User.create!(
    name: 'Test User1',
    email: 'testuser1@email.com',
    password: '123abc'
  )
  puts "Created Test User 1: #{test_user_1.id}"

  create_clock_events(0, 5, test_user_1, 'Test User 1', 6)

  # multiple Clock in/outs per day
  (0..5).to_a.each do |index|
    clock_in_event_2 = ClockEvent.create!(
      user: test_user_1,
      clock_in: true,
      occurred_at_date: Time.zone.now.beginning_of_day - index.days,
      occurred_at_time: Time.zone.now - index.days + 2.hours
    )

    clock_out_event_2 = ClockEvent.create!(
      user: test_user_1,
      clock_in: false,
      occurred_at_date: Time.zone.now.beginning_of_day - index.days,
      occurred_at_time: Time.zone.now + 6.hours - index.days + 4.hours,
      hours_clocked: 2,
      clock_in_id: clock_in_event_2.id
    )

    clock_in_event_2.update(clock_out_id: clock_out_event_2.id)
    puts "Created ANOTHER Clock In for Test User 1: #{index} - #{clock_in_event_2.id} #{clock_in_event_2.occurred_at_date} -- #{clock_in_event_2.clock_in}"
    puts "Created ANOTHER Clock Out for Test User 1: #{index} - #{clock_out_event_2.id} #{clock_out_event_2.occurred_at_date} -- #{clock_out_event_2.clock_in}"
  end

  clock_in_event = ClockEvent.create!(
    user: test_user_1,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day,
    occurred_at_time: Time.zone.now + 6.hours
  )
  puts "Created Single Clock in Event for TestUser1: #{clock_in_event.id} #{clock_in_event.occurred_at_date} -- #{clock_in_event.clock_in}"
end

def create_test_user_2
  test_user_2 = User.create!(
    name: 'Test User2',
    email: 'testuser2@email.com',
    password: '123abc'
  )
  puts "Created Test User 2: #{test_user_2.id}"

  create_clock_events(0, 7, test_user_2, 'Test User 2', 1)
end

def create_test_user_3
  test_user_3 = User.create!(
    name: 'Test User3',
    email: 'testuser3@email.com',
    password: '123abc'
  )
  puts "Created Test User 3: #{test_user_3.id}"

  create_clock_events(3, 15, test_user_3, 'Test User 3', 3)

  clock_in_event = ClockEvent.create!(
    user: test_user_3,
    clock_in: true,
    occurred_at_date: Time.zone.now.beginning_of_day,
    occurred_at_time: Time.zone.now
  )
  puts "Created Single Clock in Event for TestUser3: #{clock_in_event.id} #{clock_in_event.occurred_at_date} -- #{clock_in_event.clock_in}"

end

def create_clock_events(start_number, end_number, user, username, hour_difference)
  (start_number..end_number).to_a.each do |index|
    clock_in_event = ClockEvent.create!(
      user: user,
      clock_in: true,
      occurred_at_date: Time.zone.now.beginning_of_day - index.days,
      occurred_at_time: Time.zone.now - index.days
    )

    clock_out_event = ClockEvent.create!(
      user: user,
      clock_in: false,
      occurred_at_date: Time.zone.now.beginning_of_day - index.days,
      occurred_at_time: Time.zone.now + hour_difference.hours - index.days,
      hours_clocked: hour_difference,
      clock_in_id: clock_in_event.id
    )
    clock_in_event.update(clock_out_id: clock_out_event.id)
    puts "Created Clock In for #{username}: #{index} - #{clock_in_event.id} #{clock_in_event.occurred_at_date} -- #{clock_in_event.clock_in}"
    puts "Created Clock Out for #{username}: #{index} - #{clock_out_event.id} #{clock_out_event.occurred_at_date} -- #{clock_out_event.clock_in}"
  end
end


create_admin_user
puts "----------------------------------------------------"
create_test_user_1
puts "----------------------------------------------------"
create_test_user_2
puts "----------------------------------------------------"
create_test_user_3
puts "----------------------------------------------------"





