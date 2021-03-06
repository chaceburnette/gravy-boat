class DicomService

  def self.anonymize_directory(path, patient_id)
    include DICOM
    @patient_id = patient_id
    dicom_files = Dir.glob("#{path}/**/*")
    dicom_files.each do |file_path|
      dicom_file = DObject.read(file_path)
      unless dicom_file.print.empty?
        if ['SR', 'DOC'].include?(dicom_file.modality.value)
          delete_file(file_path)
        else
          anonymize(dicom_file)
          dicom_file.write(file_path)
        end
      end
    end
  end

  private

  def self.delete_file(file_path)
    File.delete(file_path) if File.exists?(file_path)
  end

  def self.anonymize(dicom_file)
    anonymize_field(dicom_file["0008,0080"], "Institution Name")
    anonymize_field(dicom_file["0008,0081"], "Institution Address")
    anonymize_field(dicom_file["0008,1070"], "Operator Name")
    anonymize_field(dicom_file["0008,0090"], "Referring Physician")
    anonymize_field(dicom_file["0010,0010"], "injuryId #{@patient_id}")
    anonymize_field(dicom_file["0010,0030"], "Patient D.O.B.")
  end

  def self.anonymize_field(field, new_value)
    field.value = new_value if field.present?
  end
end
