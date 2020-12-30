require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:employee_role) { FactoryBot.create(:role)}
  let(:admin_role) { FactoryBot.create(:role, role_type: 'admin')}

  describe 'to_s' do
    it 'returns a name if the user has one set' do
      expect(user.to_s).to eql(user.name)
    end

    it 'returns an email if the user has not set a name' do
      user.update(name: nil)
      expect(user.to_s).to eql(user.email)
    end
  end

  describe 'admin?' do
    it 'returns true if the user has the admin role' do
      FactoryBot.create(:user_role, role: admin_role, user: user)
      expect(user.admin?).to eql(true)
    end

    it 'returns false if the user has no role' do
      expect(user.admin?).to eql(false)
    end

    it 'returns false if the user has an employee role, but not an admin role' do
      FactoryBot.create(:user_role, role: employee_role, user: user)
      expect(user.admin?).to eql(false)
    end
  end
end
