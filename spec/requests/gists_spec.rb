require 'rails_helper'

describe 'Gists' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:gituhb]
  end

  it 'lists private gists' do
    VCR.use_cassette('github/gists') do
      visit '/'
      click_link 'Sign In with Github'
      expect(page).to have_content('Private Gists')
      expect(page).to have_content('.gitconfig')
      expect(page).not_to have_content('Public test gist')
    end
  end

  it 'creates a new gist' do
    VCR.use_cassette('github/list_and_create_gist') do
      visit '/'
      click_link 'Sign In with Github'
      click_link 'New gist'
      fill_in 'Description', with: 'Test gist spec'
      fill_in 'Filename', with: 'testspec.rb'
      fill_in 'Content', with: 'Test gist spec'
      click_button 'Create Gist'
      expect(page).to have_content('Test gist spec')
      expect(page).to have_content 'Gist was successfully created.'
    end
  end

  it 'updates an existing gist' do
    VCR.use_cassette('github/list_and_update_gist') do
      visit '/'
      click_link 'Sign In with Github'
      click_link 'Test description 123'
      fill_in 'Description', with: 'Test description 456'
      click_button 'Update Gist'
      expect(page).to have_content('Test description 456')
      expect(page).to have_content 'Gist was successfully updated.'
    end
  end

  it 'deletes a gist' do
    VCR.use_cassette('github/list_and_delete_gist') do
      visit '/'
      click_link 'Sign In with Github'
      expect(page).to have_content('Updated private gist')
      find(:xpath, "//a[@href='/gists/7eec1175afef86ca8010c91d1d013ed7']").click
      expect(page).not_to have_content('Updated private gist')
      expect(page).to have_content 'Gist was successfully deleted.'
    end
  end
end
