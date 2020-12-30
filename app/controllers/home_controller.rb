# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    clock_in_events = ClockEvent.by_user(current_user)
    .where("clock_in = ? AND occurred_at_date = ?", true, Time.zone.now.beginning_of_day)
    .order(occurred_at_time: :desc)

    @hours_logged_today  = ClockEvent.by_user(current_user)
    .where("clock_in = ? AND occurred_at_date = ?", false, Time.zone.now.beginning_of_day)
    .sum(:hours_clocked)

    @clock_events = ClockEventMapper.map_clock_events(clock_in_events)
  end
end
