class AddAnonymousFilePathToMriImages < ActiveRecord::Migration[5.1]
  def change
  	add_column :mri_images, :anonymous_file, :string
  end
end
