require 'zip'

class AnonymizerJob < ActiveJob::Base
  queue_as :anonymizer

  def perform(mri_image_id)
    begin
      @mri_image = MriImage.find(mri_image_id)
      set_paths
      download_file
      extract_file
      anonymize_files
      zip_files
      upload_file
      save_anonymous_file_path
      cleanup
    rescue => error
      cleanup
      Rollbar.error(error, image_id: @mri_image.id, error: error)
    end
  end

  private

  def set_paths
    @original_file_path = @mri_image.file
    @directory_name = File.dirname(@mri_image.file)
    @extracted_destination = "#{@directory_name}/extracted"
    @anonymized_zip_path = "#{@directory_name}/anonymous.zip"
  end

  def download_file
    ensure_directory
    Rollbar.info('downloading file', image_id: @mri_image.id)
    AWSService.create_s3_client.get_object(bucket: AWSService.bucket_name, key: @mri_image.file, response_target: @original_file_path)
  end

  def extract_file
    Rollbar.info('extracting file')
    FileUtils.mkdir_p(@extracted_destination)

    ::Zip::File.open(@original_file_path) do |zip_file|
      zip_file.each do |f|
        filePath = File.join(@extracted_destination, f.name)
        fileDirectory = File.dirname(filePath)
        FileUtils.mkpath(fileDirectory)
        zip_file.extract(f, filePath) unless File.exist?(filePath)
      end
    end
  end

  def anonymize_files
    Rollbar.info('anonymizing file', image_id: @mri_image.id)
    DicomService.anonymize_directory(@extracted_destination)
  end

  def zip_files
    Rollbar.info('zipping file', image_id: @mri_image.id)
    ::Zip::File.open(@anonymized_zip_path, 'w') do |zipfile|
      Dir.glob("#{@extracted_destination}/**/*")
        .reject{ |file| File.basename(file).start_with?("._") }
        .each do |file|
          relative_path = file.gsub("#{@extracted_destination}/", '')
          zipfile.add(relative_path, file)
        end
    end
  end

  def upload_file
    Rollbar.info('uploading file', image_id: @mri_image.id)
    bucket = AWSService.create_s3_resource.bucket(AWSService.bucket_name)
    file_obj = bucket.object("#{@directory_name}/anonymous.zip").upload_file(@anonymized_zip_path, { acl: 'public-read' })
  end

  def cleanup
    Rollbar.info('performing cleanup', image_id: @mri_image.id)
    path_unique_id = @original_file_path.split('/')[1]
    FileUtils.rm_rf("upload/#{path_unique_id}")
  end

  def save_anonymous_file_path
    @mri_image.anonymous_file = @anonymized_zip_path
    @mri_image.save
  end

  def ensure_directory
    unless File.directory?(@directory_name)
      FileUtils.mkdir_p(@directory_name)
    end
  end
end
