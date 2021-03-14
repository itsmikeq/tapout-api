# frozen_string_literal: true

FactoryBot.define do
  factory :campaign_quota do
    association :campaign
  end
end
