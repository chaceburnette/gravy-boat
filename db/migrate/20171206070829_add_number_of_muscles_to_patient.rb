class AddNumberOfMusclesToPatient < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :number_of_muscles, :integer
  end
end
