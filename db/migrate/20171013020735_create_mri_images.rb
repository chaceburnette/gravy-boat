class CreateMriImages < ActiveRecord::Migration[5.1]
  def change
    create_table :mri_images do |t|
      t.string :file

      t.timestamps
    end
  end
end
