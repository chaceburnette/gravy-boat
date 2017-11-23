class AnonymizerJob < ActiveJob::Base
  queue_as :anonimyzer

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
      Rails.logger.error(error)
      cleanup
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
    Rails.logger.info('downloading file')
    AWSService.create_s3_client.get_object(bucket: AWSService.bucket_name, key: @mri_image.file, response_target: @original_file_path)
  end

  def extract_file
    Rails.logger.info('extracting file')
    FileUtils.mkdir_p(@extracted_destination)

    Zip::File.open(@original_file_path) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(@extracted_destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end

  def anonymize_files
    Rails.logger.info('anonymizing file')
    DicomService.anonymize_directory(@extracted_destination)
  end

  def zip_files
    Rails.logger.info('zipping file')
    Zip::File.open(@anonymized_zip_path, 'w') do |zipfile|
      Dir.glob("#{@extracted_destination}/**/*.*")
        .reject{ |file| File.basename(file).start_with?("._") }
        .each do |file|
          zipfile.add(File.basename(file), file)
        end
    end
  end

  def upload_file
    Rails.logger.info('uploading file')
    bucket = AWSService.create_s3_resource.bucket(AWSService.bucket_name)
    file_obj = bucket.object("#{@directory_name}/anonymous.zip").upload_file(@anonymized_zip_path)
  end

  def cleanup
    Rails.logger.info('performing cleanup')
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
