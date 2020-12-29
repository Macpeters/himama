# frozen_string_literal: true

class ClockEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @clock_events = ClockEvent.all.order(occurred_at: :desc)

    @clock_events = ClockEvent.order("date_trunc('day', occurred_at) DESC, user_id DESC")

    # dates = ClockEvent
    # @grouped =  ClockEvent.group("date_trunc('day', occurred_at) DESC")
     #.pluck("date_trunc('day', occurred_at)", :user_id)
    # users = User.all
    # users.each do |user|
    #   @clock_events << {
    #     user: user,

    #   }
    # end
  end

  def create
    clock_in = !ClockEvent&.most_recent_event_for(current_user)&.clock_in
    clock_in = true if clock_in.nil?
    ClockEvent.create(user: current_user, occurred_at: DateTime.now, clock_in: clock_in)
    redirect_to :root, notice: "Time Event was Clocked"
  end
end
