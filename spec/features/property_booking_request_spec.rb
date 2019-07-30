feature 'Booking a property' do
  scenario ' A user can request to book a property' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    visit('/')
    click_link('Manor House')
    expect(page).to have_content 'Booking Request'
  end
end

feature 'Booking a property' do
  scenario 'A user can fill in a form with their request details' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    visit('/')
    click_link('Manor House')
    visit("/book_property/URI.escape(property.name)")
    expect(page).to have_button('Submit')
  end

  scenario 'A user can submit a booking request' do
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    visit('/')
    click_link('Manor House')
    visit("/book_property/URI.escape(property.name)")
    fill_in :name, with: 'Joshy'
    fill_in :email, with: 'joshy@josh.co.uk'
    fill_in :name, with: 'Joshy'
    fill_in :number, with: '00998877665'
    fill_in :start, with: '23/06/2020'
    fill_in :end, with: '29/06/2020'
    click_button('Submit')
    expect(page).to have_content 'Welcome'
  end
end
