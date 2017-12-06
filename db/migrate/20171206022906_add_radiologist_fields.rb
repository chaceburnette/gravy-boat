class AddRadiologistFields < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :muscle, :string
    add_column :patients, :peetrons_grade, :integer
    add_column :patients, :origin_lesion_distance, :decimal
    add_column :patients, :muscle_length, :decimal
    add_column :patients, :free_tendon_involvement, :boolean
    add_column :patients, :central_tendon_disruption, :boolean
    add_column :patients, :musculotendinous, :boolean
    add_column :patients, :fluid_collection, :string
    add_column :patients, :retraction_distance, :decimal
  end
end
