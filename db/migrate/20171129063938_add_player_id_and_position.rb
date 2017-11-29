class AddPlayerIdAndPosition < ActiveRecord::Migration[5.1]
  def change
  	add_column :patients, :player_id, :string
  	add_column :patients, :player_position, :string
  	add_column :patients, :reinjury, :boolean
  end
end
