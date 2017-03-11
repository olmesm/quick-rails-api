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

ActiveRecord::Schema.define(version: 20170221211016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_workflows", force: :cascade do |t|
    t.integer  "board_id"
    t.integer  "workflow_id"
    t.json     "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["board_id", "workflow_id"], name: "index_board_workflows_on_board_id_and_workflow_id", unique: true, using: :btree
    t.index ["board_id"], name: "index_board_workflows_on_board_id", using: :btree
    t.index ["workflow_id"], name: "index_board_workflows_on_workflow_id", using: :btree
  end

  create_table "boards", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_boards_on_organization_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.json     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "step_tasks", force: :cascade do |t|
    t.integer  "step_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id", "task_id"], name: "index_step_tasks_on_step_id_and_task_id", unique: true, using: :btree
    t.index ["step_id"], name: "index_step_tasks_on_step_id", using: :btree
    t.index ["task_id"], name: "index_step_tasks_on_task_id", using: :btree
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.text     "description"
    t.json     "data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_steps_on_organization_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.text     "description"
    t.json     "data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_tasks_on_organization_id", using: :btree
  end

  create_table "workflow_steps", force: :cascade do |t|
    t.integer  "workflow_id"
    t.integer  "step_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["step_id", "workflow_id"], name: "index_workflow_steps_on_step_id_and_workflow_id", unique: true, using: :btree
    t.index ["step_id"], name: "index_workflow_steps_on_step_id", using: :btree
    t.index ["workflow_id"], name: "index_workflow_steps_on_workflow_id", using: :btree
  end

  create_table "workflows", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.text     "description"
    t.json     "data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_workflows_on_organization_id", using: :btree
  end

  add_foreign_key "board_workflows", "boards"
  add_foreign_key "board_workflows", "workflows"
  add_foreign_key "boards", "organizations"
  add_foreign_key "step_tasks", "steps"
  add_foreign_key "step_tasks", "tasks"
  add_foreign_key "steps", "organizations"
  add_foreign_key "tasks", "organizations"
  add_foreign_key "workflow_steps", "steps"
  add_foreign_key "workflow_steps", "workflows"
  add_foreign_key "workflows", "organizations"
end
