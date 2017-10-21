class AddInjuryDateToPatient < ActiveRecord::Migration[5.1]
  def change
  	add_column :patients, :injury_date, :datetime
  end
end
