# frozen_string_literal: true

class TapResearchImportJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    TapResearchService.pull_campaigns
  end
end
