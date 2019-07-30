feature 'Booking a property' do
  scenario ' A user can request to book a property' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    visit('/')
    click_link('Manor House')
    expect(page).to have_content 'Book Manor House'
  end
end
