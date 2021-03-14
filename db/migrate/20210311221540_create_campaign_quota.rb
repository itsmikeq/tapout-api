# frozen_string_literal: true

class CreateCampaignQuota < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_quota do |t|
      t.references :campaign, null: false, foreign_key: true
      t.timestamps
    end
  end
end
