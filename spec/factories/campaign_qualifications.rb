# frozen_string_literal: true

FactoryBot.define do
  factory :campaign_qualification do
    question_id { rand(1..1_000) }
    pre_codes { [1, 2, 3] }
    association :campaign_quota
  end
end
