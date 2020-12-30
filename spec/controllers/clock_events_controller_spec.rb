require 'rails_helper'

describe ClockEventsController do
  let(:clock_event) { FactoryBot.create(:clock_event) }
  let(:user) { FactoryBot.create(:user) }
  let(:admin_role) { FactoryBot.create(:role, role_type: 'admin')}

  before(:each) do
    # auth_headers = user.create_new_auth_token
    # request.headers.merge!(auth_headers)
  end


  describe 'POST create' do
    before do
      allow(@controller).to receive(:current_user) { user }
    end

    it 'creates a clock event with the current user' do
      post :create, params: {}
      expect(ClockEvent.count).to eql(1)
      expect(ClockEvent.last.user_id).to eql(user.id)
    end

    it 'automatically decides if this is clock in or out' do
      FactoryBot.create(:clock_event, user_id: user.id, clock_in: true)
      post :create, params: {}
      expect(ClockEvent.last.clock_in).to eql(false)
    end

    it 'updates a matching clock in event if this is a clock out event' do
      clock_in_event = FactoryBot.create(:clock_event, user_id: user.id, clock_in: true)
      post :create, params: {}
      clock_in_event.reload
      expect(clock_in_event.clock_out_id).to eql(ClockEvent.last.id)
    end

    it 'finds a matching clock in event if this is a clock out event' do
      clock_in_event = FactoryBot.create(:clock_event, user_id: user.id, clock_in: true)
      post :create, params: {}
      expect(ClockEvent.last.clock_in_id).to eql(clock_in_event.id)
    end

    it 'handles cases where a user forgets to clock out'
  end

  describe 'DELETE destroy' do
    it 'allows an admin to delete any event'
    it 'allows an employee to delete their own events'
    it 'prevents an employee from deleting events belonging to anyone else'
  end


  describe 'POST update' do
    xit 'allows an admin to edit the event' do
      put :update, params: {
        id: user.id,
        clock_event: {  }
      }
    end
  end
end
