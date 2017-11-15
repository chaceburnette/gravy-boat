class Patient < ApplicationRecord
	validates_presence_of :name

	has_many :mri_images
end
