require 'spec_helper'
require 'rails_helper'

class MessageBroadcastJobTest
  describe MessageBroadcastJobTest, :type => :job do
    describe "performn later" do
      it "send message" do
        ActiveJob::Base.queue_adapter = :test
        expect{ MessageBroadcastJob.perform_later(Message.last) }.to enqueue_job.on_queue("default")
      end
    end
  end
end