# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_many :campaign_quotas, inverse_of: :campaign, dependent: :destroy
  has_many :campaign_qualifications, through: :campaign_quotas
  validates :name, :cpi, :length_of_interview, presence: true

  def as_json(options = {})
    super(options.merge(except: %w[created_at updated_at]))
  end
end
