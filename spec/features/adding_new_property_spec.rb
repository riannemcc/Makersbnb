feature 'Adding new property' do
  scenario 'A user can add a property to the listing page' do
    visit('/list_property')
    fill_in('name', with: 'Manor House')
    fill_in('description', with: 'Gorgeous')
    fill_in('price', with: 5000)
    click_button('Enter')
    expect(page).to have_content 'Manor House'
  end
end
