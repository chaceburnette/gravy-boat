class AddReadToPatient < ActiveRecord::Migration[5.1]
  def change
  	add_column :patients, :read, :boolean, default: false
  end
end
