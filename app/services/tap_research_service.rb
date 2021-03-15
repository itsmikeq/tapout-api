# frozen_string_literal: true

class TapResearchService
  include HTTParty
  base_uri "https://#{Rails.configuration.api_base_url}"
  basic_auth Rails.application.credentials.tapresearch[:email],
             Rails.application.credentials.tapresearch[:api_token]

  def self.pull_campaigns
    new.pull_campaigns
  end

  def pull_campaigns
    campaigns.each do |campaign_json|
      # This is a little odd looking but what we're doing here is looking for a campaign.
      # If the campaign does not exist, then we create a new one.
      campaign = if (campaign = Campaign.find_by(id: campaign_json['id']))
                   campaign.update!(cpi: campaign_json['cpi'], length_of_interview: campaign_json['length_of_interview'], name: campaign_json['name'])
                   campaign
                 else
                   Campaign.create!(id: campaign_json['id'], cpi: campaign_json['cpi'], length_of_interview: campaign_json['length_of_interview'], name: campaign_json['name'])
                 end
      # Quotas are embedded in the campaign
      campaign_quotas = campaign(campaign.id)['campaign_quotas']
      # Sometimes there is nothing
      next unless campaign_quotas.any?
      campaign_quotas.each do |campaign_quota|
        cq = CampaignQuota.create_or_find_by!(campaign_id: campaign.id, id: campaign_quota['id'])
        campaign_quota['campaign_qualifications'].each do |campaign_qualification|
          # and qualifications are embedded in the quota
          cqu = CampaignQualification.create_or_find_by!(question_id: campaign_qualification['question_id'], campaign_quota_id: cq.id)
          # these are just faster to update instead of doing a bunch of checks,  we're mirroring data, not building it
          # so we'll not his this too much (i think, i mean this is an example app)
          cqu.update!(pre_codes: campaign_qualification['pre_codes'])
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
