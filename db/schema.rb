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

ActiveRecord::Schema.define(version: 2018_07_09_103530) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.string "short_id", limit: 10, default: "", null: false
    t.integer "story_id", null: false, unsigned: true
    t.integer "user_id", null: false, unsigned: true
    t.integer "parent_comment_id", unsigned: true
    t.integer "thread_id", unsigned: true
    t.text "comment", limit: 16777215, null: false
    t.integer "upvotes", default: 0, null: false
    t.integer "downvotes", default: 0, null: false
    t.decimal "confidence", precision: 20, scale: 19, default: "0.0", null: false
    t.text "markeddown_comment", limit: 16777215
    t.boolean "is_deleted", default: false
    t.boolean "is_moderated", default: false
    t.boolean "is_from_email", default: false
    t.integer "hat_id"
    t.index ["comment"], name: "index_comments_on_comment", type: :fulltext
    t.index ["confidence"], name: "confidence_idx"
    t.index ["short_id"], name: "short_id", unique: true
    t.index ["story_id", "short_id"], name: "story_id_short_id"
    t.index ["thread_id"], name: "thread_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hat_requests", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "hat", limit: 255, collation: "utf8mb4_general_ci"
    t.string "link", limit: 255, collation: "utf8mb4_general_ci"
    t.text "comment", collation: "utf8mb4_general_ci"
  end

  create_table "hats", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "granted_by_user_id"
    t.string "hat", limit: 255, null: false
    t.string "link", limit: 255, collation: "utf8mb4_general_ci"
    t.boolean "modlog_use", default: false
    t.datetime "doffed_at"
  end

  create_table "hidden_stories", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.index ["user_id", "story_id"], name: "index_hidden_stories_on_user_id_and_story_id", unique: true
  end

  create_table "invitation_requests", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code", limit: 255
    t.boolean "is_verified", default: false
    t.string "email", limit: 255
    t.string "name", limit: 255
    t.text "memo"
    t.string "ip_address", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "email", limit: 255
    t.string "code", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "memo", limit: 16777215
    t.datetime "used_at"
    t.integer "new_user_id"
  end

  create_table "keystores", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", limit: 50, default: "", null: false
    t.bigint "value"
    t.index ["key"], name: "key", unique: true
  end

  create_table "messages", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "author_user_id", unsigned: true
    t.integer "recipient_user_id", unsigned: true
    t.boolean "has_been_read", default: false
    t.string "subject", limit: 100
    t.text "body", limit: 16777215
    t.string "short_id", limit: 30
    t.boolean "deleted_by_author", default: false
    t.boolean "deleted_by_recipient", default: false
    t.bigint "hat_id"
    t.index ["hat_id"], name: "index_messages_on_hat_id"
    t.index ["short_id"], name: "random_hash", unique: true
  end

  create_table "moderations", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "moderator_user_id"
    t.integer "story_id"
    t.integer "comment_id"
    t.integer "user_id"
    t.text "action", limit: 16777215
    t.text "reason", limit: 16777215
    t.boolean "is_from_suggestions", default: false
    t.integer "tag_id"
    t.index ["created_at"], name: "index_moderations_on_created_at"
  end

  create_table "read_ribbons", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.boolean "is_following", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "story_id"
    t.index ["story_id"], name: "index_read_ribbons_on_story_id"
    t.index ["user_id"], name: "index_read_ribbons_on_user_id"
  end

  create_table "saved_stories", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "story_id"
    t.index ["user_id", "story_id"], name: "index_saved_stories_on_user_id_and_story_id", unique: true
  end

  create_table "stories", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "user_id", unsigned: true
    t.string "url", limit: 250, default: ""
    t.string "title", limit: 150, default: "", null: false
    t.text "description", limit: 16777215
    t.string "short_id", limit: 6, default: "", null: false
    t.boolean "is_expired", default: false, null: false
    t.integer "upvotes", default: 0, null: false, unsigned: true
    t.integer "downvotes", default: 0, null: false, unsigned: true
    t.boolean "is_moderated", default: false, null: false
    t.decimal "hotness", precision: 20, scale: 10, default: "0.0", null: false
    t.text "markeddown_description", limit: 16777215
    t.text "story_cache", limit: 16777215
    t.integer "comments_count", default: 0, null: false
    t.integer "merged_story_id"
    t.datetime "unavailable_at"
    t.string "twitter_id", limit: 20
    t.boolean "user_is_author", default: false
    t.string "picture", limit: 255
    t.index ["created_at"], name: "index_stories_on_created_at"
    t.index ["description"], name: "index_stories_on_description", type: :fulltext
    t.index ["hotness"], name: "hotness_idx"
    t.index ["is_expired", "is_moderated"], name: "is_idxes"
    t.index ["is_expired"], name: "index_stories_on_is_expired"
    t.index ["is_moderated"], name: "index_stories_on_is_moderated"
    t.index ["merged_story_id"], name: "index_stories_on_merged_story_id"
    t.index ["short_id"], name: "unique_short_id", unique: true
    t.index ["story_cache"], name: "index_stories_on_story_cache", type: :fulltext
    t.index ["title"], name: "index_stories_on_title", type: :fulltext
    t.index ["twitter_id"], name: "index_stories_on_twitter_id"
    t.index ["url"], name: "url", length: 191
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "suggested_taggings", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "story_id"
    t.integer "tag_id"
    t.integer "user_id"
  end

  create_table "suggested_titles", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "story_id"
    t.integer "user_id"
    t.string "title", limit: 150, default: "", null: false, collation: "utf8mb4_general_ci"
  end

  create_table "tag_filters", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "tag_id"
    t.index ["user_id", "tag_id"], name: "user_tag_idx"
  end

  create_table "taggings", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "story_id", null: false, unsigned: true
    t.integer "tag_id", null: false, unsigned: true
    t.index ["story_id", "tag_id"], name: "story_id_tag_id", unique: true
  end

  create_table "tags", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tag", limit: 25, null: false
    t.string "description", limit: 100
    t.boolean "privileged", default: false
    t.boolean "is_media", default: false
    t.boolean "inactive", default: false
    t.float "hotness_mod", default: 0.0
    t.index ["tag"], name: "tag", unique: true
  end

  create_table "users", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", limit: 50, collation: "utf8mb4_general_ci"
    t.string "email", limit: 100, collation: "utf8mb4_general_ci"
    t.string "password_digest", limit: 75, collation: "utf8mb4_general_ci"
    t.datetime "created_at"
    t.boolean "is_admin", default: false
    t.string "password_reset_token", limit: 75, collation: "utf8mb4_general_ci"
    t.string "session_token", limit: 75, default: "", null: false, collation: "utf8mb4_general_ci"
    t.text "about", limit: 16777215, collation: "utf8mb4_general_ci"
    t.integer "invited_by_user_id"
    t.boolean "is_moderator", default: false
    t.boolean "pushover_mentions", default: false
    t.string "rss_token", limit: 75, collation: "utf8mb4_general_ci"
    t.string "mailing_list_token", limit: 75, collation: "utf8mb4_general_ci"
    t.integer "mailing_list_mode", default: 0
    t.integer "karma", default: 0, null: false
    t.datetime "banned_at"
    t.integer "banned_by_user_id"
    t.string "banned_reason", limit: 200, collation: "utf8mb4_general_ci"
    t.datetime "deleted_at"
    t.datetime "disabled_invite_at"
    t.integer "disabled_invite_by_user_id"
    t.string "disabled_invite_reason", limit: 200
    t.text "settings"
    t.index ["mailing_list_mode"], name: "mailing_list_enabled"
    t.index ["mailing_list_token"], name: "mailing_list_token", unique: true
    t.index ["password_reset_token"], name: "password_reset_token", unique: true
    t.index ["rss_token"], name: "rss_token", unique: true
    t.index ["session_token"], name: "session_hash", unique: true
    t.index ["username"], name: "username", unique: true
  end

  create_table "votes", id: :bigint, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false, unsigned: true
    t.integer "story_id", null: false, unsigned: true
    t.integer "comment_id", unsigned: true
    t.integer "vote", limit: 1, null: false
    t.string "reason", limit: 1
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_votes_on_comment_id"
    t.index ["user_id", "comment_id"], name: "user_id_comment_id"
    t.index ["user_id", "story_id"], name: "user_id_story_id"
  end


  create_view "replying_comments",  sql_definition: <<-SQL
      select `read_ribbons`.`user_id` AS `user_id`,`comments`.`id` AS `comment_id`,`read_ribbons`.`story_id` AS `story_id`,`comments`.`parent_comment_id` AS `parent_comment_id`,`comments`.`created_at` AS `comment_created_at`,`parent_comments`.`user_id` AS `parent_comment_author_id`,`comments`.`user_id` AS `comment_author_id`,`stories`.`user_id` AS `story_author_id`,(`read_ribbons`.`updated_at` < `comments`.`created_at`) AS `is_unread`,(select `votes`.`vote` from `votes` where ((`votes`.`user_id` = `read_ribbons`.`user_id`) and (`votes`.`comment_id` = `comments`.`id`))) AS `current_vote_vote`,(select `votes`.`reason` from `votes` where ((`votes`.`user_id` = `read_ribbons`.`user_id`) and (`votes`.`comment_id` = `comments`.`id`))) AS `current_vote_reason` from (((`read_ribbons` join `comments` on((`comments`.`story_id` = `read_ribbons`.`story_id`))) join `stories` on((`stories`.`id` = `comments`.`story_id`))) left join `comments` `parent_comments` on((`parent_comments`.`id` = `comments`.`parent_comment_id`))) where ((`read_ribbons`.`is_following` = 1) and (`comments`.`user_id` <> `read_ribbons`.`user_id`) and (`comments`.`is_deleted` = 0) and (`comments`.`is_moderated` = 0) and ((`parent_comments`.`user_id` = `read_ribbons`.`user_id`) or (isnull(`parent_comments`.`user_id`) and (`stories`.`user_id` = `read_ribbons`.`user_id`))) and ((`comments`.`upvotes` - `comments`.`downvotes`) >= 0) and (isnull(`parent_comments`.`id`) or ((`parent_comments`.`upvotes` - `parent_comments`.`downvotes`) >= 0)))
  SQL

end
