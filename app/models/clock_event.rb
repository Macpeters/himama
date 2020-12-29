class ClockEvent < ApplicationRecord
  belongs_to :user

  scope :by_user, ->(user) {
    where(user: user)
  }

  scope :this_day, ->(day){
    where(
      "date_trunc('day',occurred_at) = ?", day
    )
  }

  def self.most_recent_event_for(current_user)
    ClockEvent.by_user(current_user).last
  end

  def in_or_out
    return 'In' if clock_in == true
    return 'Out'
  end
end
