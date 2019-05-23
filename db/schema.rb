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

ActiveRecord::Schema.define(version: 2019_02_14_123006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace', limit: 255
    t.text 'body'
    t.string 'resource_id', limit: 255, null: false
    t.string 'resource_type', limit: 255, null: false
    t.integer 'author_id'
    t.string 'author_type', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['author_type', 'author_id'], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index ['resource_type', 'resource_id'], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', limit: 255, default: '', null: false
    t.string 'encrypted_password', limit: 255, default: '', null: false
    t.string 'reset_password_token', limit: 255
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip', limit: 255
    t.string 'last_sign_in_ip', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'doctrine_taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.integer 'doctrine_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['doctrine_id'], name: 'index_doctrine_taggings_on_doctrine_id'
    t.index ['tag_id'], name: 'index_doctrine_taggings_on_tag_id'
  end

  create_table 'doctrines', force: :cascade do |t|
    t.string 'file_name', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.boolean 'publish'
  end

  create_table 'e_answers', force: :cascade do |t|
    t.integer 'e_question_id'
    t.text 'answer'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'rehearsal_id'
  end

  create_table 'e_questions', force: :cascade do |t|
    t.integer 'exercise_id'
    t.text 'question'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'exercise_taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.integer 'exercise_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['exercise_id'], name: 'index_exercise_taggings_on_exercise_id'
    t.index ['tag_id'], name: 'index_exercise_taggings_on_tag_id'
  end

  create_table 'exercises', force: :cascade do |t|
    t.string 'title', limit: 255
    t.text 'general_description'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'user_id'
    t.boolean 'global'
  end

  create_table 'mailers', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_mailers_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_mailers_on_reset_password_token', unique: true
  end

  create_table 'quotation_taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.integer 'quotation_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['quotation_id'], name: 'index_quotation_taggings_on_quotation_id'
    t.index ['tag_id'], name: 'index_quotation_taggings_on_tag_id'
  end

  create_table 'quotations', force: :cascade do |t|
    t.string 'title', limit: 255
    t.text 'passage'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.boolean 'publish'
  end

  create_table 'rehearsals', force: :cascade do |t|
    t.integer 'tally'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'exercise_id'
    t.integer 'user_id'
    t.string 'city'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', limit: 255, default: '', null: false
    t.string 'encrypted_password', limit: 255, default: '', null: false
    t.string 'reset_password_token', limit: 255
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip', limit: 255
    t.string 'last_sign_in_ip', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.boolean 'admin'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

end
