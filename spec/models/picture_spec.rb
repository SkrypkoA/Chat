require 'rails_helper'

RSpec.describe Picture, type: :model do
  before(:each) { @picture = FactoryGirl.build(:picture) }

  describe "check fields" do
    it { expect(@picture).to respond_to(:user) }
    it { expect(@picture).to respond_to(:description) }
    it { expect(@picture).to respond_to(:location) }
    it { expect(@picture).to respond_to(:likes_count) }
    it { expect(@picture).to respond_to(:likes) }
    it { expect(@picture).to respond_to(:comments) }
    is_expected { respond_to(:comments) }
  end

  describe "the location must be present" do
    before {@picture.location = nil}
    it { expect(@picture).not_to be_valid }
  end

  describe "sent mail after saving" do
    before do
      @picture.category.users << @picture.user
    end
    it { expect { @picture.save }.to change { ActionMailer::Base.deliveries.count }.by(1)}
  end

  describe "check dependent destroy likes" do
    it do
      @picture.save
      FactoryGirl.create(:like, user: @picture.user, picture: @picture)
      picture_likes = @picture.likes.to_a
      @picture.destroy
      expect(picture_likes).not_to be_empty
      picture_likes.each  do |like|
        expect(Like.where(id: like.id)).to be_empty
      end
    end
  end

  describe "check dependent destroy messages" do
    it do
      @picture.save
      FactoryGirl.create(:comment, user: @picture.user, picture: @picture)
      picture_comments = @picture.comments.to_a
      @picture.destroy
      expect(picture_comments).not_to be_empty
      picture_comments.each  do |comment|
        expect(Like.where(id: comment.id)).to be_empty
      end
    end
  end

  describe "pictures must be sorted by descending number of likes" do
    it do
      @picture.save
      @user = FactoryGirl.create(:user)
      @second_picture = FactoryGirl.create(:picture, user: @user, category: @picture.category)
      FactoryGirl.create(:like, user: @picture.user, picture: @picture)
      FactoryGirl.create(:like, user: @user, picture: @picture)
      FactoryGirl.create(:like, user: @user, picture: @second_picture)
      expect(Picture.all.to_a).to eq([@picture,@second_picture])
    end
  end
end
