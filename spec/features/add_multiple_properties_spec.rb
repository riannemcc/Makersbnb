feature 'Adding multiple properties' do
  scenario 'A user can add a second property to the listing page' do
    sign_up
    list_property_2
    expect(page).to have_content('Not Granny Annexe')
  end
end
