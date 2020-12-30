require 'rails_helper'

RSpec.describe ClockEvent, type: :model do
  let(:clock_event) { FactoryBot.create(:clock_event) }
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'returns an error if a clock out event cannot find a matching clock in event' do
      clock_event = ClockEvent.create(
      user: user,
      occurred_at_time: Time.zone.now,
      occurred_at_date: Time.zone.now.beginning_of_day,
      clock_in: false,
      clock_in_id: nil,
      hours_clocked: 0
    )
    expect(clock_event.valid?).to be false
    end
  end

  describe 'in_or_out' do
    it 'returns In when clock_in is true' do
      expect(clock_event.clock_in).to eql(true)
      expect(clock_event.in_or_out).to eql('In')
    end

    it 'returns Out when clock_in is false' do
      clock_event.update(clock_in: false)
      expect(clock_event.in_or_out).to eql('Out')
    end
  end
end
