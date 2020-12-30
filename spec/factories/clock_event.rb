FactoryBot.define do
  factory :clock_event do
    user
    clock_in { true }
    occurred_at_date { Time.now.utc }
    occurred_at_time { Time.now.utc }
  end
end