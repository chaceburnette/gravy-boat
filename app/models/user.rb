class User < ApplicationRecord
  has_secure_password

  has_many :user_role
  has_many :roles, through: :user_role

  def admin?
    roles.map(&:name).include?(Role::ADMIN)
  end

  def uploader?
    roles.map(&:name).include?(Role::UPLOADER)
  end

  def image_viewer?
    roles.map(&:name).include?(Role::IMAGE_VIEWER)
  end

  def team_viewer?
    roles.map(&:name).include?(Role::TEAM_VIEWER)
  end
end
