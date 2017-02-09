require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = FactoryGirl.create(:category)
  end

  subject { @category }

  describe "check fields" do
    it { expect(@category).to respond_to(:name) }
    it { expect(@category).to respond_to(:description) }
    it { expect(@category).to respond_to(:pictures) }
    it { expect(@category).to respond_to(:user_categories) }
    it { expect(@category).to respond_to(:users) }
  end

  describe "check pesent" do
    before { @category.name = " "}
    it { expect(@category).to_not be_valid}
  end

  describe "check uniqueness" do
    before { @category_copy = @category.dup}
    it { expect(@category_copy).to_not be_valid }
  end

end
