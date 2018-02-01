class User < ApplicationRecord
  has_secure_password

  has_many :user_role, :dependent => :destroy
  has_many :roles, through: :user_role
  has_many :user_patients
  has_many :patients, through: :user_patients

  before_save :normalize

  def admin?
    roles.map(&:name).include?(Role::ADMIN)
  end

  def uploader?
    admin? || roles.map(&:name).include?(Role::UPLOADER)
  end

  def image_viewer?
    admin? || roles.map(&:name).include?(Role::IMAGE_VIEWER)
  end

  def normalize
    email.downcase!
  end
end
