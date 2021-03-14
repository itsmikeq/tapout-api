# frozen_string_literal: true

class CampaignQualification < ApplicationRecord
  belongs_to :campaign_quota, touch: true

  def as_json(options = {})
    # don't merge options here, they are not needed and extra stuff was
    # pp options
    super(options.merge(except: %w[created_at updated_at campaign_quota_id id]))
  end
end
