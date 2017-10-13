class MriImagesController < ApplicationController
	before_action :set_patient
	def index
		@mri_images = @patient.mri_images
	end

	def new
	end

	def create
		mri_image = MriImage.new(file: params[:file].open)
		mri_image.patient = @patient
		mri_image.save
	end

	private

	def set_patient
		@patient = Patient.find(params[:patient_id])
	end
end
