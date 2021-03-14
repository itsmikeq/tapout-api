# frozen_string_literal: true

require 'rails_helper'

describe CampaignsController, type: :controller do
  before do
    TapResearchService.pull_campaigns
  end

  it 'responds with the correct ID first' do
    get :ordered_campaigns, format: :json
    expect(json_response.first['id']).to eq(278_564)
  end
end
