# frozen_string_literal: true

class CampaignsController < ApplicationController
  def ordered_campaigns
    resp = Campaign
           .includes(:campaign_qualifications, :campaign_quotas)
           .joins('left join campaign_quota cqa on cqa.campaign_id = campaigns.id')
           .joins('left join campaign_qualifications cqb on cqb.campaign_quota_id = cqa.id')
           .strict_loading.order('count(cqb.campaign_quota_id)')
           .group('campaigns.id')
           .collect do |camp|
      things = camp.campaign_quotas.collect { |e| e.as_json.merge(campaign_qualifications: camp.campaign_qualifications) }
      camp.as_json.merge(campaign_quotas: things)
    end
    render json: resp
  end
end
