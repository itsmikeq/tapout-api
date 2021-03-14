# frozen_string_literal: true

class CreateCampaignQualifications < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_qualifications do |t|
      t.references :campaign_quota, null: false, foreign_key: true
      t.integer :question_id, null: false
      t.text :pre_codes, array: true, default: []

      t.timestamps
    end
    add_index :campaign_qualifications, %i[question_id campaign_quota_id], unique: true, name: 'cqa_question_id_campaign_quota_id'
  end
end
