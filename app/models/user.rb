class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :clock_events

  def admin?
    roles.where(role_type: 'admin').any?
  end

  def to_s
    return name if name.present?
    return email
  end
end
