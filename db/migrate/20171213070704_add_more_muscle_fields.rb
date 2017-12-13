class AddMoreMuscleFields < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :edema_largest_csa, :decimal
    add_column :patients, :edema_longitude_length, :decimal
    add_column :patients, :hamstring_largest_csa, :decimal
    add_column :patients, :quadricep_largest_csa, :decimal

    add_column :patients, :secondary_edema_largest_csa, :decimal
    add_column :patients, :secondary_edema_longitude_length, :decimal
    add_column :patients, :secondary_hamstring_largest_csa, :decimal
    add_column :patients, :secondary_quadricep_largest_csa, :decimal
  end
end
