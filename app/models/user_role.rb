class UserRole < ApplicationRecord
	has_one :user
	has_one :role
end
