class MriImage < ApplicationRecord
	mount_uploader :file, MriUploader

	belongs_to :patient
end
