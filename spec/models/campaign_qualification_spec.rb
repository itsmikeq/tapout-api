# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignQualification, type: :model do
  let(:campaign_qualification) { create(:campaign_qualification) }
  it 'only shows the required fields' do
    expect(campaign_qualification.as_json.keys).not_to include(%w[created_at updated_at campaign_quota_id])
  end
end
