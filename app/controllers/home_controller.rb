# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @clock_events = ClockEvent.by_user(current_user).where("occurred_at > ?", DateTime.now.beginning_of_day).order(occurred_at: :desc)
  end
end
