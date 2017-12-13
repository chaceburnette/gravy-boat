class AddSecondaryMuscleFields < ActiveRecord::Migration[5.1]
  def change
  	add_column :patients, :free_tendon_proximal_distal, :string
    add_column :patients, :central_tendon_proximal_distal, :string
    add_column :patients, :musculotendinous_proximal_distal, :string

  	add_column :patients, :secondary_muscle, :string
    add_column :patients, :secondary_peetrons_grade, :integer
    add_column :patients, :secondary_origin_lesion_distance, :decimal
    add_column :patients, :secondary_muscle_length, :decimal
    add_column :patients, :secondary_free_tendon_involvement, :boolean
    add_column :patients, :secondary_central_tendon_disruption, :boolean
    add_column :patients, :secondary_musculotendinous, :boolean
  	add_column :patients, :secondary_free_tendon_proximal_distal, :string
    add_column :patients, :secondary_central_tendon_proximal_distal, :string
    add_column :patients, :secondary_musculotendinous_proximal_distal, :string
    add_column :patients, :secondary_fluid_collection, :string
    add_column :patients, :secondary_retraction_distance, :decimal
  end
end
