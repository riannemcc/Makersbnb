feature 'Adding new property' do
  scenario 'A user can add a property to the listing page' do
    sign_up
    list_property
    expect(page).to have_content('Granny Annexe')
  end
end
