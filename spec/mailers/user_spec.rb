require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include CarrierWave::Test::Matchers
  let(:user) { FactoryGirl.create(:user) }
  let(:picture) { FactoryGirl.create(:picture) }
  let(:mail) { UserMailer.add_picture_notification(user, picture) }

  # before do
  #   AvatarUploader.enable_processing = true
  # end
  #
  # after do
  #   # AvatarUploader.enable_processing = false
  #   FileUtils.rm_rf(Dir["#{Rails.root}/public/test_uploads"])
  # end

  it "renders the headers" do
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["ixsiwat@gmail.com"])
  end

  describe "renders the body" do
    it "should has a header " do
      expect(mail.body.encoded).to match("NEW PICTURE!")
    end

    it "should has a picture category name" do
      expect(mail.body.encoded).to match("new picture in category #{picture.category.name}")
    end

    it "should has a picture" do
      expect(mail.body.encoded).to have_selector('img.picture')
      expect(mail.attachments.count).to eq(1)
    end
  end
end
