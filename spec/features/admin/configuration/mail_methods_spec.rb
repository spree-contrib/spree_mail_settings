RSpec.feature 'Mail Methods' do
  stub_authorization!

  background do
    visit spree.admin_path
  end

  context 'edit' do
    background do
      click_link 'Mail Method Settings'
    end

    scenario 'can edit mail method settings' do
      fill_in 'mail_bcc', with: 'spree@example.com99'
      click_button 'Update'
      expect(page).to have_content('successfully updated!')
    end

    # Regression test for #2094
    scenario 'clears password if username not provided' do
      Spree::Config[:smtp_password] = 'haxme'
      Spree::Config[:smtp_username] = 'haxme'
      click_button 'Update'
      expect(page).to have_content('successfully updated!')
      expect(Spree::Config[:smtp_password]).to be_blank
    end
  end
end
