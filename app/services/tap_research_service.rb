# frozen_string_literal: true

class TapResearchService
  include HTTParty
  base_uri "https://#{Rails.configuration.api_base_url}"
  basic_auth Rails.application.credentials.tapreasearch[:email],
             Rails.application.credentials.tapreasearch[:api_token]

  def self.pull_campaigns
    new.pull_campaigns
  end

  def pull_campaigns
    campaigns.each do |campaign_json|
      campaign = Campaign.create_or_find_by!(id: campaign_json['id'], cpi: campaign_json['cpi'], length_of_interview: campaign_json['length_of_interview'], name: campaign_json['name'])
      campaign_quotas = campaign(campaign.id)['campaign_quotas']
      # Sometimes there is nothing
      next unless campaign_quotas.any?

      campaign_quotas.each do |campaign_quota|
        cq = CampaignQuota.create_or_find_by!(campaign_id: campaign.id, id: campaign_quota['id'])
        campaign_quota['campaign_qualifications'].each do |campaign_qualification|
          CampaignQualification.create_or_find_by!(question_id: campaign_qualification['question_id'], pre_codes: campaign_qualification['pre_codes'], campaign_quota: cq)
        end
      end
    end
  end

  def campaigns
    # We memoize these because the dataset is small.
    # If there was pagination or similar upstream, we may want to do this differently
    @campaigns ||= self.class.get('/api/v1/campaigns')
  end

  def campaign(id)
    self.class.get("/api/v1/campaigns/#{id}")
  end

  def all_quotas
    campaigns.collect do |campaign|
      self.class.get("/api/v1/campaigns/#{campaign['id']}")['campaign_quotas']
    end
  end
end
