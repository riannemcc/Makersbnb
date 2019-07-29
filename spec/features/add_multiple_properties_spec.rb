feature 'Adding multiple properties' do
  scenario 'A user can add a second property to the listing page' do
    visit('/list_property')
    fill_in('name', with: 'Granny annexe')
    fill_in('description', with: 'Old')
    fill_in('price', with: 20000)
    click_button('Enter')
    expect(page).to have_content 'Granny annexe'
  end
end
