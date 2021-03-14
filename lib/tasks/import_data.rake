# frozen_string_literal: true

namespace :import_data do
  desc 'Get all of our campaigns from TapResearch and insert them 👍'
  task run: :environment do
    TapResearchService.pull_campaigns
  end
end
