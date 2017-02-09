require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  render_views
  let!(:event) { FactoryGirl.create(:event) }

  it "show all events  belong to current user"do
    sign_in event.user
    get :index
    expect(response.body).to match /table-bordered/
  end

end
