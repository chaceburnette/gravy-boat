class DicomService

  def self.anonymize_directory(path)
    include DICOM

    dicom_files = Dir.glob("#{path}/**/*.dcm")
    dicom_files.each do |file_path|
      dicom_file = DObject.read(file_path)
      dicom_file.anonymize
      dicom_file.write(file_path)
    end
  end

end