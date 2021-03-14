class TapResearchImportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TapResearchService.pull_campaigns
  end
end
