# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignQuota, type: :model do
  let(:campaign_quota) { create(:campaign_quota) }
  it 'only shows the required fields' do
    expect(campaign_quota.as_json.keys).not_to include(%w[created_at updated_at campaign_id])
  end
end
