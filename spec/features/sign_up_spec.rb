feature 'sign up' do
  scenario 'a user can sign up' do
    visit '/'
    fill_in('name', with: 'Sayonara')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password123')
    fill_in('password_confirmation', with: 'password123')
    click_button('Sign up')

    expect(page).to have_content "Welcome to Crouching Python B'n'B"
  end
end

feature 'Authentication' do
      scenario 'a user can sign in' do
        User.create(name: 'Joshy', email: 'test@example.com', password: 'password123')
        visit '/sign_in'
        fill_in('email', with: 'test@example.com')
        fill_in('password', with: 'password123')
        click_button('Sign in')
        expect(page).to have_content "Welcome to Crouching Python B'n'B"
      end

    scenario 'a user sees an error if they get their email wrong' do
        User.create(name: 'Joshy', email: 'test@example.com', password: 'password123')
        visit '/sign_in'
        fill_in('email', with: 'test@example.commmm')
        fill_in('password', with: 'password123')
        click_button('Sign in')
        expect(page).not_to have_content "Welcome to Crouching Python B'n'B"
        expect(page).to have_content "Please check your email and password."
    end
end
