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

ActiveRecord::Schema.define(:version => 20130422090857) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "teacher_id"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "announce_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "announcement_id"
  end

  create_table "announce_fieldings", :force => true do |t|
    t.integer  "announce_category_id"
    t.integer  "home_page_tab_field_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "announcement_translations", :force => true do |t|
    t.integer  "announcement_id"
    t.string   "locale"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "title_url"
  end

  add_index "announcement_translations", ["announcement_id"], :name => "index_5ab9a4f290f5831e288ca0088d32c79311c8d7ad"
  add_index "announcement_translations", ["locale"], :name => "index_announcement_translations_on_locale"

  create_table "announcements", :force => true do |t|
    t.string   "name"
    t.date     "due_date"
    t.text     "content"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "announce_category_id"
    t.date     "announce_date"
    t.integer  "department_id"
    t.datetime "deleted_at"
    t.boolean  "sticky"
    t.string   "title_url"
    t.boolean  "picked_by_management"
  end

  create_table "carousel_translations", :force => true do |t|
    t.integer  "carousel_id"
    t.string   "locale"
    t.text     "caption"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "link_url"
    t.datetime "deleted_at"
  end

  add_index "carousel_translations", ["carousel_id"], :name => "index_carousel_translations_on_carousel_id"
  add_index "carousel_translations", ["locale"], :name => "index_carousel_translations_on_locale"

  create_table "carousels", :force => true do |t|
    t.string   "title"
    t.string   "link_url"
    t.text     "caption"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "department_id"
    t.integer  "ordering"
    t.datetime "deleted_at"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "course_translations", :force => true do |t|
    t.integer  "course_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "course_url"
  end

  add_index "course_translations", ["course_id"], :name => "index_course_translations_on_course_id"
  add_index "course_translations", ["locale"], :name => "index_course_translations_on_locale"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "teacher_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "document_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "document_translations", :force => true do |t|
    t.integer  "document_id"
    t.string   "locale"
    t.text     "discription"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "document_translations", ["document_id"], :name => "index_document_translations_on_document_id"
  add_index "document_translations", ["locale"], :name => "index_document_translations_on_locale"

  create_table "documents", :force => true do |t|
    t.text     "discription"
    t.integer  "document_category_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "document_file"
    t.string   "document_file_file_name"
    t.string   "document_file_content_type"
    t.integer  "document_file_file_size"
    t.datetime "document_file_updated_at"
    t.integer  "department_id"
    t.integer  "announcement_id"
    t.integer  "news_report_id"
    t.integer  "page_id"
    t.datetime "deleted_at"
  end

  create_table "educational_background_translations", :force => true do |t|
    t.integer  "educational_background_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "educational_background_translations", ["educational_background_id"], :name => "index_803252512f8f01f49e40ccda3b5d2da06ccfd84e"
  add_index "educational_background_translations", ["locale"], :name => "index_educational_background_translations_on_locale"

  create_table "educational_backgrounds", :force => true do |t|
    t.string   "name"
    t.string   "require_year"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "teacher_id"
  end

  create_table "home_page_configs", :force => true do |t|
    t.integer  "department_id"
    t.string   "contact_info"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "phone_one"
    t.string   "phone_two"
    t.string   "tax_num"
    t.string   "address"
    t.string   "eng_address"
    t.string   "old_link"
  end

  create_table "home_page_tab_field_translations", :force => true do |t|
    t.integer  "home_page_tab_field_id"
    t.string   "locale"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "home_page_tab_field_translations", ["home_page_tab_field_id"], :name => "index_61cc278ba2b93759881a0331a8b082a0d4bb6a23"
  add_index "home_page_tab_field_translations", ["locale"], :name => "index_home_page_tab_field_translations_on_locale"

  create_table "home_page_tab_fields", :force => true do |t|
    t.integer  "home_page_config_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.boolean  "visible"
    t.datetime "deleted_at"
    t.string   "youtube_channel_account"
  end

  create_table "news_report_translations", :force => true do |t|
    t.integer  "news_report_id"
    t.string   "locale"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "preview_text"
  end

  add_index "news_report_translations", ["locale"], :name => "index_news_report_translations_on_locale"
  add_index "news_report_translations", ["news_report_id"], :name => "index_news_report_translations_on_news_report_id"

  create_table "news_reports", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "department_id"
    t.boolean  "text_up"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.string   "preview_color"
    t.string   "preview_text"
    t.date     "announce_date"
    t.datetime "deleted_at"
  end

  create_table "newweb_teacher_publications", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "author"
    t.string   "year"
    t.string   "title"
    t.string   "journal_or_conference_orpublisher"
    t.integer  "publication_type_id"
    t.string   "date"
    t.string   "location"
    t.text     "other"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "page_part_translations", :force => true do |t|
    t.integer  "page_part_id"
    t.string   "locale"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "deleted_at"
  end

  add_index "page_part_translations", ["locale"], :name => "index_page_part_translations_on_locale"
  add_index "page_part_translations", ["page_part_id"], :name => "index_page_part_translations_on_page_part_id"

  create_table "page_parts", :force => true do |t|
    t.datetime "deleted_at"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.string   "menu_title"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
    t.string   "title_url"
  end

  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "menu_title"
    t.integer  "page_part_ids"
    t.integer  "rgt"
    t.integer  "lft"
    t.integer  "depth"
    t.integer  "parent_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "content"
    t.integer  "position"
    t.integer  "department_id"
    t.string   "path"
    t.string   "type"
    t.string   "url_name"
    t.string   "delegated_to"
    t.datetime "deleted_at"
    t.string   "title_url"
  end

  create_table "publication_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "research_area_translations", :force => true do |t|
    t.integer  "research_area_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "research_area_translations", ["locale"], :name => "index_research_area_translations_on_locale"
  add_index "research_area_translations", ["research_area_id"], :name => "index_188cfa6d0995f7ffea2f12a9d681ed5cf26eb778"

  create_table "research_areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "researchings", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "research_area_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "role_playings", :force => true do |t|
    t.integer  "role_id"
    t.integer  "admin_user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_page_section_translations", :force => true do |t|
    t.integer  "sub_page_section_id"
    t.string   "locale"
    t.string   "section_title"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "deleted_at"
  end

  add_index "sub_page_section_translations", ["locale"], :name => "index_sub_page_section_translations_on_locale"
  add_index "sub_page_section_translations", ["sub_page_section_id"], :name => "index_e312298f26a692b3c39730703d023198be36f56f"

  create_table "sub_page_sections", :force => true do |t|
    t.datetime "deleted_at"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_page_translations", :force => true do |t|
    t.integer  "sub_page_id"
    t.string   "locale"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "deleted_at"
  end

  add_index "sub_page_translations", ["locale"], :name => "index_sub_page_translations_on_locale"
  add_index "sub_page_translations", ["sub_page_id"], :name => "index_sub_page_translations_on_sub_page_id"

  create_table "sub_pages", :force => true do |t|
    t.text     "content"
    t.string   "title"
    t.integer  "page_id"
    t.datetime "deleted_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "sub_page_section_id"
    t.string   "locale"
    t.integer  "department_id"
  end

  create_table "teacher_title_translations", :force => true do |t|
    t.integer  "teacher_title_id"
    t.string   "locale"
    t.string   "title_name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "teacher_title_translations", ["locale"], :name => "index_teacher_title_translations_on_locale"
  add_index "teacher_title_translations", ["teacher_title_id"], :name => "index_7025d7b1c8f012c194fc767e0df2dacb6e617ae2"

  create_table "teacher_titles", :force => true do |t|
    t.string   "title_name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "teacher_order", :default => 0
  end

  create_table "teacher_translations", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "locale"
    t.string   "name"
    t.string   "room"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "honor"
    t.text     "history"
  end

  add_index "teacher_translations", ["locale"], :name => "index_teacher_translations_on_locale"
  add_index "teacher_translations", ["teacher_id"], :name => "index_teacher_translations_on_teacher_id"

  create_table "teachers", :force => true do |t|
    t.integer  "admin_user_id"
    t.integer  "department_id"
    t.string   "name"
    t.string   "phone"
    t.string   "cellphone"
    t.integer  "teacher_title_id"
    t.string   "email"
    t.string   "homepage"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "tax_number"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "room"
    t.datetime "deleted_at"
    t.string   "joint_with"
    t.integer  "front_end_order"
    t.boolean  "picked_by_emba"
    t.boolean  "picked_by_gmba"
    t.boolean  "use_newweb_data"
  end

end
