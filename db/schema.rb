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

ActiveRecord::Schema.define(version: 20181226211943) do

  create_table "comments", force: :cascade do |t|
    t.string   "discussion_id"
    t.string   "uuid"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "comments", ["discussion_id"], name: "index_comments_on_discussion_id"
  add_index "comments", ["uuid"], name: "index_comments_on_uuid", unique: true

  create_table "discussions", force: :cascade do |t|
    t.string   "post_id"
    t.string   "uuid"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "discussions", ["post_id"], name: "index_discussions_on_post_id"
  add_index "discussions", ["uuid"], name: "index_discussions_on_uuid", unique: true

  create_table "posts", force: :cascade do |t|
    t.string   "stream_id"
    t.string   "uuid"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["stream_id"], name: "index_posts_on_stream_id"
  add_index "posts", ["uuid"], name: "index_posts_on_uuid", unique: true

  create_table "streams", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "user_id"
    t.string   "title"
    t.string   "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "details"
  end

  add_index "streams", ["uuid"], name: "index_streams_on_uuid", unique: true

  create_table "uploads", force: :cascade do |t|
    t.string   "uploadable_id"
    t.string   "uploadable_type"
    t.string   "attachment_type"
    t.string   "uuid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "uploads", ["attachment_type"], name: "index_uploads_on_attachment_type"
  add_index "uploads", ["uploadable_id"], name: "index_uploads_on_uploadable_id"
  add_index "uploads", ["uploadable_type"], name: "index_uploads_on_uploadable_type"
  add_index "uploads", ["uuid"], name: "index_uploads_on_uuid", unique: true

end
