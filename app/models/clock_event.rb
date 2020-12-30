class ClockEvent < ApplicationRecord
  belongs_to :user

  validates :clock_in_id, presence: true, unless: :clock_in

  scope :by_user, ->(user) {
    where(user: user)
  }

  def self.most_recent_event_for(current_user)
    ClockEvent.by_user(current_user).last
  end

  def in_or_out
    return 'In' if clock_in == true
    return 'Out'
  end
end
