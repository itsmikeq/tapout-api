# frozen_string_literal: true

require 'rails_helper'

describe TapResearchService do
  let(:campaigns_json) { build(:campaigns_json) }
  before do
    # set the api url here because we want to use the web server: TestWebServer
    Rails.configuration.api_base_url = 'localhost'
  end

  describe 'instance methods' do
    subject { described_class.new }
    context 'Inserting data' do
      it 'inserts campaigns when called but only once' do
        expect { subject.pull_campaigns }.to change { Campaign.count }.by(9)
        expect { subject.pull_campaigns }.to change { Campaign.count }.by(0)
      end
      it 'inserts campaigns -> campaign_quotas when called but only once' do
        expect { subject.pull_campaigns }.to change { CampaignQuota.count }.by(7)
        expect { subject.pull_campaigns }.to change { CampaignQuota.count }.by(0)
      end
      it 'inserts campaign_quotas -> campaign_qualifications when called but only once' do
        expect { subject.pull_campaigns }.to change { CampaignQualification.count }.by(8)
        expect { subject.pull_campaigns }.to change { CampaignQualification.count }.by(0)
      end
    end
  end
end
