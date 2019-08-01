feature 'Booking a property' do
  scenario ' A user can request to book a property' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    sign_up
    click_button('View')
    expect(page).to have_content 'Booking Request'
  end
end

feature 'Booking a property' do
  scenario 'A user can fill in a form with their request details and submit' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    sign_up
    list_property
    click_button("View", :match => :first)
    expect(page).to have_button('Submit')
  end
end

feature 'Booking a property' do
  scenario 'A user can submit a booking request' do
    sign_up
    list_property
    book_property_2
    click_button('Submit')
    expect(page).to have_content('Granny Annexe')
  end
end
