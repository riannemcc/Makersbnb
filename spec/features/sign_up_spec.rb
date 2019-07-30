feature 'sign up' do
  scenario 'a user can sign up' do
    visit '/sign_up'
    fill_in('name', with: 'Sayonara')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    fill_in('password_confirmation', with: 'password123')
    click_button('Sign up')

    expect(page).to have_content "Welcome to CrouchingPythonBNB"
  end
end
