require 'rails_helper'
require 'sidekiq/testing'
require 'sidekiq/testing/inline'
Sidekiq::Testing.fake!
RSpec.describe TapResearchImportJob, type: :job do
  include ActiveJob::TestHelper
  context 'in the instance' do
    it 'hits the service' do
      # this is all we're doing here, the service itself will be tested in its own context
      expect(TapResearchService).to receive(:pull_campaigns)
      described_class.new.perform
    end
  end

  context 'running the job' do
    it 'enqueues a job to default queue' do
      job = described_class.perform_later
      expect(job.queue_name).to eq('default')
    end

    it 'queues up a job in the queue' do
      expect do
        described_class.perform_later
      end.to change { (enqueued_jobs.size) }.by(1)
    end
  end

end
