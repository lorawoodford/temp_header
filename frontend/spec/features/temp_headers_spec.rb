# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe 'Temp Headers', js: true do
  before(:all) do
    @repository = create(:repo, repo_code: "temp_header_test_#{Time.now.to_i}")

    run_all_indexers
  end

  before(:each) do
    login_user(user)
    select_repository(@repository)
  end

  context 'when an admin user' do
    let(:user) { BackendClientMethods::ASpaceUser.new('admin', 'admin') }

    it 'lets you access the header with default settings' do
      click_button('Repository settings')
      find_button('Plug-ins').hover
      click_on('Update Temporary Header')

      expect(page).to have_text 'Temporary Header'

      expect(find('#temp_header_show_header_').checked?).to eq(false)
      expect(find('#temp_header_notice_date_').value).to eq('')
      expect(find('#temp_header_maintenance_start_').value).to eq('')
      expect(find('#temp_header_maintenance_end_').value).to eq('')
      expect(find('#temp_header_maintenance_message_').value).to eq('')
    end

    it 'lets you update the temp header' do
      click_button('Repository settings')
      find_button('Plug-ins').hover
      click_on('Update Temporary Header')

      expect(page).to have_text 'Temporary Header'

      fill_in('Notice Date', with: '2025-09-01')
      fill_in('Maintenance Start Time', with: '2025-09-10 6:00am')
      fill_in('Maintenance End Time', with: '2025-09-10 8:00am')
      fill_in('Maintenance Message', with: 'A maintenance message')

      within '.record-pane' do
        click_on('Save Temporary Header')
      end

      expect(page).to have_text 'Temporary Header Updated'

      expect(find('#temp_header_notice_date_').value).to eq('2025-09-01')
      expect(find('#temp_header_maintenance_start_').value).to eq('2025-09-10 06:00:00 UTC')
      expect(find('#temp_header_maintenance_end_').value).to eq('2025-09-10 08:00:00 UTC')
      expect(find('#temp_header_maintenance_message_').value).to eq('A maintenance message')
    end

    it 'makes the header visible on all pages when show header is true' do
      visit '/'

      expect(page).to have_css('#toggle-temp-header', visible: false)
      expect(page).not_to have_text('ArchivesSpace will be undergoing planned maintenance')

      click_button('Repository settings')
      find_button('Plug-ins').hover
      click_on('Update Temporary Header')

      expect(page).to have_text 'Temporary Header'

      check 'Show Header?'

      within '.record-pane' do
        click_on('Save Temporary Header')
      end

      expect(page).to have_text 'Temporary Header Updated'
      expect(find('#temp_header_show_header_').checked?).to eq(true)

      visit '/'

      expect(page).to have_css('#toggle-temp-header', visible: true)
      expect(page).to have_text('ArchivesSpace will be undergoing planned maintenance')
    end

    it 'allows you to reset header settings to defaults' do
      click_button('Repository settings')
      find_button('Plug-ins').hover
      click_on('Update Temporary Header')

      expect(page).to have_text 'Temporary Header'

      fill_in('Maintenance Message', with: 'A new maintenance message')

      within '.record-pane' do
        click_on('Save Temporary Header')
      end

      expect(page).to have_text 'Temporary Header Updated'

      expect(find('#temp_header_maintenance_message_').value).to eq('A new maintenance message')

      click_on 'Reset Temporary Header'
      within '#confirmChangesModal' do
        click_on 'Reset Temporary Header'
      end

      expect(page).to have_text 'Temporary Header reset'

      expect(find('#temp_header_show_header_').checked?).to eq(false)
      expect(find('#temp_header_notice_date_').value).to eq('')
      expect(find('#temp_header_maintenance_start_').value).to eq('')
      expect(find('#temp_header_maintenance_end_').value).to eq('')
      expect(find('#temp_header_maintenance_message_').value).to eq('')
    end
  end

  context 'when an archivist user' do
    let(:user) do
      user = create_user(@repository => ['repository-archivists'])
      run_index_round

      user
    end

    it 'does not show a link to header settings' do
      click_button('Repository settings')
      find_button('Plug-ins').hover

      expect(page).not_to have_text 'Update Temporary Header'
    end

    it 'does not let you access the header settings' do
      visit '/plugins/temp_headers/edit'

      expect(page).to have_text "The page you've tried to access may no longer exist or you may not have permission to view it."
    end

    it 'makes the header visible on all pages when show header is true' do
      visit '/'

      expect(page).to have_css('#toggle-temp-header', visible: false)
      expect(page).not_to have_text('ArchivesSpace will be undergoing planned maintenance')

      login_admin

      click_button('Repository settings')
      find_button('Plug-ins').hover
      click_on('Update Temporary Header')

      expect(page).to have_text 'Temporary Header'

      check 'Show Header?'
      fill_in('Notice Date', with: '2025-09-01')
      fill_in('Maintenance Start Time', with: '2025-09-10 6:00am')
      fill_in('Maintenance End Time', with: '2025-09-10 8:00am')
      fill_in('Maintenance Message', with: 'A maintenance message from an admin')

      within '.record-pane' do
        click_on('Save Temporary Header')
      end

      expect(page).to have_text 'Temporary Header Updated'
      expect(find('#temp_header_show_header_').checked?).to eq(true)

      visit '/logout'

      login_user(user)

      visit '/'

      expect(page).to have_css('#toggle-temp-header', visible: true)
      expect(page).to have_text('ArchivesSpace will be undergoing planned maintenance')
    end
  end
end
