# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:campaign) { create(:campaign) }
  it 'only shows the required fields' do
    # since we are removing some fields, lets check them here.
    expect(campaign.as_json.keys).not_to include(%w[created_at updated_at])
  end
end
