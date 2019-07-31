feature 'Adding multiple properties' do
  scenario 'A user can add a second property to the listing page' do
    sign_up
    list_property
    expect(page).to have_button('Granny Annexe')
  end
end
