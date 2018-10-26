require 'rails_helper'

describe 'Sessions' do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:gituhb]
  end

  it 'user signs in' do
    VCR.use_cassette('github/gists') do
      visit '/'
      expect(page).to have_content('Please Sign In')
      click_link 'Sign In with Github'
      expect(page).to have_selector(:link_or_button, 'Sign Out')
    end
  end

  it 'user signs out' do
    VCR.use_cassette('github/gists') do
      visit '/'
      click_link 'Sign In with Github'
      click_button 'Sign Out'
      expect(page).to have_content('Please Sign In')
    end
  end
end