# frozen_string_literal: true

class CampaignQuota < ApplicationRecord
  belongs_to :campaign, inverse_of: :campaign_quotas, touch: true
  has_many :campaign_qualifications, inverse_of: :campaign_quota, dependent: :destroy

  def as_json(options = {})
    super(options.merge(except: %w[created_at updated_at campaign_id]))
  end
end
