class MriImagesController < AuthController
	before_action :set_patient
	def index
		@mri_images = @patient.mri_images
	end

	def new
		temporary_credentials = AWSService.get_temporary_credentials
		@patient_id = params[:patient_id]
		@bucket = AWSService.bucket_name
		@region = AWSService.region
        @awskey = temporary_credentials.credentials.access_key_id
        @awssecret = temporary_credentials.credentials.secret_access_key
        @session_token = temporary_credentials.credentials.session_token
	end

	def create
		mri_image = MriImage.new(file: params[:filePath])
		mri_image.patient = @patient
		mri_image.save
		redirect_to action: :index
	end

	private

	def set_patient
		@patient = Patient.find(params[:patient_id])
	end
end
