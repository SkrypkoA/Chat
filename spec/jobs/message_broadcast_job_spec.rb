require 'rails_helper'
require 'rails_helper'

RSpec.describe MessageBroadcastJob, type: :job do
  describe "performn later" do
    it "send message" do
      expect{ MessageBroadcastJob.perform_later(Message.last) }.to enqueue_job.on_queue("default")
    end
  end
end
