# frozen_string_literal: true

class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.integer :length_of_interview, null: false
      t.string :cpi, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
