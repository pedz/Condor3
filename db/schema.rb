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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 47) do

  create_table "adv_ptf_release_maps", :force => true do |t|
    t.integer  "apar_defect_version_map_id", :null => false
    t.integer  "ptf_id",                     :null => false
    t.integer  "release_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adv_ptf_release_maps", ["apar_defect_version_map_id", "ptf_id", "release_id"], :name => "adv_ptf_release_maps_apar_defect_version_map_id_key", :unique => true
  add_index "adv_ptf_release_maps", ["apar_defect_version_map_id"], :name => "i3"
  add_index "adv_ptf_release_maps", ["apar_defect_version_map_id"], :name => "index_adv_ptf_release_maps_on_apar_defect_version_map_id"
  add_index "adv_ptf_release_maps", ["ptf_id"], :name => "index_adv_ptf_release_maps_on_ptf_id"
  add_index "adv_ptf_release_maps", ["release_id"], :name => "index_adv_ptf_release_maps_on_release_id"

  create_table "aix_files", :force => true do |t|
    t.string   "path",       :null => false
    t.string   "sha1",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aix_files", ["path", "sha1"], :name => "aix_files_path_key", :unique => true

  create_table "apar_defect_version_maps", :force => true do |t|
    t.integer  "apar_id",                    :null => false
    t.integer  "defect_id",                  :null => false
    t.integer  "version_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pc_id",      :default => -1, :null => false
  end

  add_index "apar_defect_version_maps", ["apar_id", "defect_id", "version_id"], :name => "apar_defect_version_maps_apar_id_key", :unique => true
  add_index "apar_defect_version_maps", ["apar_id"], :name => "i2"
  add_index "apar_defect_version_maps", ["defect_id"], :name => "i1"
  add_index "apar_defect_version_maps", ["defect_id"], :name => "index_apar_defect_version_maps_on_defect_id"
  add_index "apar_defect_version_maps", ["version_id"], :name => "index_apar_defect_version_maps_on_version_id"

  create_table "apars", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apars", ["name"], :name => "apars_name_key", :unique => true

  create_table "cmvcs", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "login",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmvcs", ["login"], :name => "cmvcs_login_key", :unique => true
  add_index "cmvcs", ["user_id"], :name => "cmvcs_user_id_key", :unique => true

  create_table "defects", :force => true do |t|
    t.string   "name",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cq_defect",  :default => "NONE", :null => false
  end

  add_index "defects", ["name"], :name => "defects_name_key", :unique => true

  create_table "families", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["name"], :name => "families_name_key", :unique => true

  create_table "fileset_aix_file_maps", :force => true do |t|
    t.integer  "fileset_id",  :null => false
    t.integer  "aix_file_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fileset_aix_file_maps", ["fileset_id", "aix_file_id"], :name => "fileset_aix_file_maps_fileset_id_key", :unique => true

  create_table "fileset_ptf_maps", :force => true do |t|
    t.integer  "fileset_id", :null => false
    t.integer  "ptf_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fileset_ptf_maps", ["fileset_id", "ptf_id"], :name => "fileset_ptf_maps_fileset_id_key", :unique => true
  add_index "fileset_ptf_maps", ["ptf_id"], :name => "i4"
  add_index "fileset_ptf_maps", ["ptf_id"], :name => "index_fileset_ptf_maps_on_ptf_id"

  create_table "filesets", :force => true do |t|
    t.integer  "lpp_id",     :null => false
    t.string   "vrmf",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filesets", ["lpp_id", "vrmf"], :name => "filesets_lpp_id_key", :unique => true

  create_table "image_paths", :force => true do |t|
    t.string   "path",       :null => false
    t.integer  "package_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_paths", ["path"], :name => "image_paths_path_key", :unique => true

  create_table "lpp_bases", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpp_bases", ["name"], :name => "lpp_bases_name_key", :unique => true

  create_table "lpps", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "lpp_base_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpps", ["name", "lpp_base_id"], :name => "lpps_name_key", :unique => true

  create_table "package_fileset_maps", :force => true do |t|
    t.integer  "package_id", :null => false
    t.integer  "fileset_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_fileset_maps", ["package_id", "fileset_id"], :name => "package_fileset_maps_package_id_key", :unique => true

  create_table "packages", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "sha1",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["name", "sha1"], :name => "packages_name_key", :unique => true

  create_table "ptfs", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ptfs", ["name"], :name => "ptfs_name_key", :unique => true

  create_table "releases", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "family_id",  :null => false
    t.integer  "version_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "releases", ["name", "family_id"], :name => "releases_name_key", :unique => true

  create_table "service_pack_fileset_maps", :force => true do |t|
    t.integer  "service_pack_id", :null => false
    t.integer  "fileset_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_pack_fileset_maps", ["fileset_id"], :name => "index_service_pack_fileset_maps_on_fileset_id"
  add_index "service_pack_fileset_maps", ["service_pack_id", "fileset_id"], :name => "service_pack_fileset_maps_service_pack_id_key", :unique => true

  create_table "service_packs", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_packs", ["name"], :name => "service_packs_name_key", :unique => true

  create_table "upd_pc_views", :force => true do |t|
    t.integer  "update_id"
    t.integer  "pc_id"
    t.string   "bc_name"
    t.integer  "ptf_id",     :null => false
    t.integer  "fileset_id", :null => false
    t.integer  "defect_id",  :null => false
    t.integer  "version_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upd_pc_views", ["update_id", "pc_id"], :name => "upd_pc_views_update_id_key", :unique => true

  create_table "users", :force => true do |t|
    t.string   "ldap_id",                       :null => false
    t.boolean  "admin",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["ldap_id"], :name => "users_ldap_id_key", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["name"], :name => "versions_name_key", :unique => true

end
