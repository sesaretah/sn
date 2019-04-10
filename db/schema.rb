# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20190404191258) do

  create_table "access_controls", force: :cascade do |t|
    t.string   "uuid",                         limit: 255
    t.string   "role_id",                      limit: 255
    t.boolean  "ability_to_create_stream"
    t.boolean  "ability_to_create_discussion"
    t.boolean  "ability_to_comment"
    t.boolean  "ability_to_create_question"
    t.boolean  "ability_to_create_answer"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "ability_to_administrate"
  end

  add_index "access_controls", ["role_id"], name: "index_access_controls_on_role_id", using: :btree
  add_index "access_controls", ["uuid"], name: "index_access_controls_on_uuid", unique: true, using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "content",     limit: 255
    t.string   "uuid",        limit: 255
    t.string   "question_id", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["uuid"], name: "index_answers_on_uuid", unique: true, using: :btree

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "role_id",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "uuid",       limit: 255
  end

  add_index "assignments", ["role_id"], name: "index_assignments_on_role_id", using: :btree
  add_index "assignments", ["uuid"], name: "index_assignments_on_uuid", unique: true, using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.string   "bookmarkable_id",   limit: 255
    t.string   "bookmarkable_type", limit: 255
    t.string   "uuid",              limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "bookmarks", ["bookmarkable_id"], name: "index_bookmarks_on_bookmarkable_id", using: :btree
  add_index "bookmarks", ["bookmarkable_type"], name: "index_bookmarks_on_bookmarkable_type", using: :btree
  add_index "bookmarks", ["uuid"], name: "index_bookmarks_on_uuid", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "discussion_id", limit: 255
    t.string   "uuid",          limit: 255
    t.text     "content",       limit: 65535
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "comments", ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
  add_index "comments", ["uuid"], name: "index_comments_on_uuid", unique: true, using: :btree

  create_table "discussions", force: :cascade do |t|
    t.string   "post_id",    limit: 255
    t.string   "uuid",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "title",      limit: 255
    t.string   "color",      limit: 255
  end

  add_index "discussions", ["post_id"], name: "index_discussions_on_post_id", using: :btree
  add_index "discussions", ["uuid"], name: "index_discussions_on_uuid", unique: true, using: :btree

  create_table "educations", force: :cascade do |t|
    t.string   "school_name", limit: 255
    t.integer  "grad_year",   limit: 4
    t.string   "country",     limit: 255
    t.string   "city",        limit: 255
    t.string   "field",       limit: 255
    t.string   "uuid",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "grad_level",  limit: 255
    t.integer  "user_id",     limit: 4
  end

  add_index "educations", ["uuid"], name: "index_educations_on_uuid", unique: true, using: :btree

  create_table "follows", force: :cascade do |t|
    t.string   "followable_id",   limit: 255
    t.string   "followable_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.integer  "status",          limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "uuid",            limit: 255
  end

  add_index "follows", ["followable_id"], name: "index_follows_on_followable_id", using: :btree
  add_index "follows", ["followable_type"], name: "index_follows_on_followable_type", using: :btree
  add_index "follows", ["uuid"], name: "index_follows_on_uuid", unique: true, using: :btree

  create_table "interconnects", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uuid",       limit: 255
    t.string   "token",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "interconnects", ["token"], name: "index_interconnects_on_token", using: :btree
  add_index "interconnects", ["uuid"], name: "index_interconnects_on_uuid", using: :btree

  create_table "likes", force: :cascade do |t|
    t.string   "likeable_id",   limit: 255
    t.string   "likeable_type", limit: 255
    t.integer  "user_id",       limit: 4
    t.string   "uuid",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "likes", ["likeable_id"], name: "index_likes_on_likeable_id", using: :btree
  add_index "likes", ["likeable_type"], name: "index_likes_on_likeable_type", using: :btree
  add_index "likes", ["uuid"], name: "index_likes_on_uuid", unique: true, using: :btree

  create_table "notification_settings", force: :cascade do |t|
    t.integer  "user_id",                     limit: 4
    t.string   "notify_streams_shares",       limit: 255, default: "000"
    t.string   "notify_posts_discussions",    limit: 255, default: "000"
    t.string   "notify_discussions_comments", limit: 255, default: "000"
    t.string   "notify_people_shares",        limit: 255, default: "000"
    t.string   "notify_follows_likes",        limit: 255, default: "000"
    t.string   "notify_authors_likes",        limit: 255, default: "000"
    t.string   "notify_follows_bookmarks",    limit: 255, default: "000"
    t.string   "notify_authors_bookmarks",    limit: 255, default: "000"
    t.string   "notify_suggestions",          limit: 255, default: "000"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "uuid",                        limit: 255
  end

  add_index "notification_settings", ["uuid"], name: "index_notification_settings_on_uuid", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "stream_id",            limit: 255
    t.string   "uuid",                 limit: 255
    t.string   "title",                limit: 255
    t.text     "content",              limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",              limit: 4
    t.text     "raw_content",          limit: 65535
    t.integer  "external_id",          limit: 4
    t.string   "provider",             limit: 255
    t.string   "link",                 limit: 255
    t.integer  "external_parent_id",   limit: 4
    t.string   "external_parent_type", limit: 255
  end

  add_index "posts", ["stream_id"], name: "index_posts_on_stream_id", using: :btree
  add_index "posts", ["uuid"], name: "index_posts_on_uuid", unique: true, using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "sex",        limit: 255
    t.text     "bio",        limit: 65535
    t.string   "uuid",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "mobile",     limit: 255
    t.integer  "integer_id", limit: 4
  end

  add_index "profiles", ["uuid"], name: "index_profiles_on_uuid", unique: true, using: :btree

  create_table "publications", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "abstract",    limit: 65535
    t.string   "link",        limit: 255
    t.string   "uuid",        limit: 255
    t.integer  "external_id", limit: 4
    t.string   "provider",    limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "content",     limit: 65535
  end

  add_index "publications", ["uuid"], name: "index_publications_on_uuid", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.string   "stream_id",  limit: 255
    t.string   "uuid",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "questions", ["stream_id"], name: "index_questions_on_stream_id", using: :btree
  add_index "questions", ["uuid"], name: "index_questions_on_uuid", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "uuid",        limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "start_point"
  end

  add_index "roles", ["uuid"], name: "index_roles_on_uuid", unique: true, using: :btree

  create_table "shares", force: :cascade do |t|
    t.string   "shareable_id",   limit: 255
    t.string   "shareable_type", limit: 255
    t.integer  "user_id",        limit: 4
    t.string   "uuid",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "stream_id",      limit: 255
  end

  add_index "shares", ["shareable_id"], name: "index_shares_on_shareable_id", using: :btree
  add_index "shares", ["shareable_type"], name: "index_shares_on_shareable_type", using: :btree
  add_index "shares", ["stream_id"], name: "index_shares_on_stream_id", using: :btree
  add_index "shares", ["uuid"], name: "index_shares_on_uuid", unique: true, using: :btree

  create_table "streams", force: :cascade do |t|
    t.string   "uuid",       limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "subdomain",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "details",    limit: 65535
  end

  add_index "streams", ["uuid"], name: "index_streams_on_uuid", unique: true, using: :btree

  create_table "uploads", force: :cascade do |t|
    t.string   "uploadable_id",           limit: 255
    t.string   "uploadable_type",         limit: 255
    t.string   "attachment_type",         limit: 255
    t.string   "uuid",                    limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 8
    t.datetime "attachment_updated_at"
  end

  add_index "uploads", ["attachment_type"], name: "index_uploads_on_attachment_type", using: :btree
  add_index "uploads", ["uploadable_id"], name: "index_uploads_on_uploadable_id", using: :btree
  add_index "uploads", ["uploadable_type"], name: "index_uploads_on_uploadable_type", using: :btree
  add_index "uploads", ["uuid"], name: "index_uploads_on_uuid", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "fullname",               limit: 255
    t.string   "username",               limit: 255
    t.string   "phone_number",           limit: 255
    t.string   "mobile",                 limit: 255
    t.boolean  "is_robot"
    t.string   "current_role_id",        limit: 255
  end

  add_index "users", ["current_role_id"], name: "index_users_on_current_role_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "walls", force: :cascade do |t|
    t.string   "shareable_id",   limit: 255
    t.string   "shareable_type", limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "walls", ["shareable_id"], name: "index_walls_on_shareable_id", using: :btree
  add_index "walls", ["shareable_type"], name: "index_walls_on_shareable_type", using: :btree

end
