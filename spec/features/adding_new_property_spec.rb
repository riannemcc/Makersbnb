feature 'Adding new property' do
  scenario 'A user can add a property to the listing page' do
    list_property
    expect(page).to have_button('Granny Annexe')
  end
end
