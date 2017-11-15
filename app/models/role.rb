class Role < ApplicationRecord
  has_many :user_role

  ADMIN = 'Admin'
  UPLOADER = 'Uploader'
  IMAGE_VIEWER = 'Image Viewer'
  TEAM_VIEWER = 'Team Viewer'
  ROLES = [ADMIN, UPLOADER, IMAGE_VIEWER, TEAM_VIEWER]
end
