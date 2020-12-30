class ClockEventMapper
  # pass in clock in events, and get a list of events with the matching clock in/out events together
  def self.map_clock_events(clock_in_events)
    clock_events = []

    # TODO: make this more performant
    clock_in_events.each do |cie|
      clock_events << {
        clock_in: cie,
        clock_out: ClockEvent.find_by(clock_in_id: cie.id)
      }
    end
    clock_events
  end
end