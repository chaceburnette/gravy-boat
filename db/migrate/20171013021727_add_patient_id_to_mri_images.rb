class AddPatientIdToMriImages < ActiveRecord::Migration[5.1]
  def change
    add_column :mri_images, :patient_id, :integer
  end
end
