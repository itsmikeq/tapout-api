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
    context 'Updating data' do
      it 'updates campaign attributes' do
        campaign = create(:campaign, id: 278562, name: "Test name")
        expect { subject.pull_campaigns }.to change { campaign.reload.name }
        expect { subject.pull_campaigns }.to change { Campaign.count }.by(0)
      end
      it 'updates campaign_quota -> campaign_qualifications when called' do
        campaign_qualification = create(:campaign_qualification,
                                        question_id: 42,
                                        pre_codes: [100, 200, 300],
                                        campaign_quota: create(:campaign_quota, id: 1118454,
                                                               campaign: create(:campaign,
                                                                                id: 278562)
                                        )
        )
        expect { subject.pull_campaigns }.to change { campaign_qualification.reload.pre_codes }
        expect { subject.pull_campaigns }.to change { CampaignQualification.count }.by(0)
      end
    end
  end
end
