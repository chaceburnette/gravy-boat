class Patient < ApplicationRecord
	validates_presence_of :name

	has_many :mri_images
	has_many :user_patients, :dependent => :destroy
end
