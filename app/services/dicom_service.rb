class DicomService

  def self.anonymize_directory(path)
    include DICOM

    dicom_files = Dir.glob("#{path}/**/*")
    dicom_files.each do |file_path|
      dicom_file = DObject.read(file_path)
      unless dicom_file.print.empty?
        dicom_file.anonymize
        dicom_file.write(file_path)
      end
    end
  end

end