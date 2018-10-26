require 'spec_helper'

describe GistsController do
  let(:user) { FactoryGirl.build(:user) }

  describe 'GET index' do
    before do
      allow(controller).to receive_messages(current_user: user)
    end

    it 'response is a success' do
      VCR.use_cassette('github/gists') do
        get :index
        expect(response).to be_success
      end
    end
  end
end
