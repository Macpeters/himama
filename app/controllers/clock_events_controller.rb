# frozen_string_literal: true

class ClockEventsController < ApplicationController
  # TODO: Authenticate admin
  before_action :authenticate_user!

  def index
    @clock_events = ClockEvent.all.order(occurred: :desc)
    users = User.all
    # users.each do |user|
    #   @clock_events << {
    #     user: user,

    #   }
    # end
  end

  def create
    ClockEvent.create(user: current_user, occurred_at: DateTime.now, clock_in: !ClockEvent.most_recent_event_for(current_user).clock_in)
    redirect_to :root
  end
end
