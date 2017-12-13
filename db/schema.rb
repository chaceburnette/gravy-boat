# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171213064657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mri_images", force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
    t.string "anonymous_file"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "injury_type"
    t.boolean "read", default: false
    t.datetime "injury_date"
    t.string "player_id"
    t.string "player_position"
    t.boolean "reinjury"
    t.string "muscle"
    t.integer "peetrons_grade"
    t.decimal "origin_lesion_distance"
    t.decimal "muscle_length"
    t.boolean "free_tendon_involvement"
    t.boolean "central_tendon_disruption"
    t.boolean "musculotendinous"
    t.string "fluid_collection"
    t.decimal "retraction_distance"
    t.integer "number_of_muscles"
    t.string "free_tendon_proximal_distal"
    t.string "central_tendon_proximal_distal"
    t.string "musculotendinous_proximal_distal"
    t.string "secondary_muscle"
    t.integer "secondary_peetrons_grade"
    t.decimal "secondary_origin_lesion_distance"
    t.decimal "secondary_muscle_length"
    t.boolean "secondary_free_tendon_involvement"
    t.boolean "secondary_central_tendon_disruption"
    t.boolean "secondary_musculotendinous"
    t.string "secondary_free_tendon_proximal_distal"
    t.string "secondary_central_tendon_proximal_distal"
    t.string "secondary_musculotendinous_proximal_distal"
    t.string "secondary_fluid_collection"
    t.decimal "secondary_retraction_distance"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
