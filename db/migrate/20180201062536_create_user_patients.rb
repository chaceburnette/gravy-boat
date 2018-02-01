class CreateUserPatients < ActiveRecord::Migration[5.1]
  def change
    create_table :user_patients do |t|
      t.integer :user_id
      t.integer :patient_id

      t.timestamps
    end
  end
end
