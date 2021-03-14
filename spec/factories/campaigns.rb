# frozen_string_literal: true

FactoryBot.define do
  factory :campaign do
    length_of_interview { rand(1..20) }
    cpi { rand(1.to_f..3.to_f).to_s.first(4) }
    name { "#{FFaker::Company.name} Campaign" }
  end
end
