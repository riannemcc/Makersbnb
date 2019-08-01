feature 'Booking a property' do
  scenario ' A user can request to book a property' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    sign_up
    click_button('Manor House')
    expect(page).to have_content 'Booking Request'
  end
end

feature 'Booking a property' do
  scenario 'A user can fill in a form with their request details' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    sign_up
    click_button('Manor House')
    visit("/book_property")
    expect(page).to have_button('Submit')
  end

  scenario 'A user can submit a booking request' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    sign_up
    book_property
    expect(page).to have_content 'Sign up'
  end
end
