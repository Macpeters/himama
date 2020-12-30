# frozen_string_literal: true

class ClockEventsController < ApplicationController
  before_action :authenticate_user!
  NUM_SECONDS_PER_HOUR = 3600

  def index
    date = params[:date]
    date ||= Time.zone.now.beginning_of_day

    clock_in_events = ClockEvent
      .where("clock_in = ? AND occurred_at_date = ?", true, date)
      .order(user_id: :asc, occurred_at_time: :desc)
      .where(clock_in: true)

    @dates = ClockEvent.all.order(occurred_at_time: :desc).pluck(:occurred_at_date).uniq

    @total_hours_worked_today = ClockEvent
      .where("clock_in = ? AND occurred_at_date = ?", false, date)
      .select(:user_id)
      .group(:user_id)
      .sum(:hours_clocked)

    @clock_events = ClockEventMapper.map_clock_events(clock_in_events)
  end

  def create
    most_recent_clock_event = ClockEvent&.most_recent_event_for(current_user)
    clock_in = !most_recent_clock_event&.clock_in
    clock_in = true if clock_in.nil?

    # for consistency, just get the current time once
    now = Time.zone.now

    unless clock_in
      clock_in_id = most_recent_clock_event.id
      hours_clocked = (now - most_recent_clock_event.occurred_at_time) / NUM_SECONDS_PER_HOUR
    end

    clock_event = ClockEvent.create(
      user: current_user,
      occurred_at_time: now,
      occurred_at_date: now.beginning_of_day,
      clock_in: clock_in,
      clock_in_id: clock_in_id,
      hours_clocked: hours_clocked
    )

    if clock_event.valid?
      most_recent_clock_event.update(clock_out_id: clock_event.id) unless clock_in
      return redirect_to :root, notice: "Time Event was Clocked"
    end
    return redirect_to :root, alert: "Time Event could not be Created"
  end

  def destroy
    clock_event = ClockEvent.find(params[:id])
    if clock_event.destroy
      return redirect_to :root, notice: "Time Event was Deleted"
    end
    redirect_to :root, alert: "Time Event could not be Deleted"
  end
end
