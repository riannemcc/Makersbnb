require 'pg'

feature 'Testing index page' do
  scenario 'index page returns properties' do

    Database.setup(makersbnb)

    Database.query("INSERT INTO properties (name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    Database.query("INSERT INTO properties (name, description, price) VALUES('Mega Pad', 'Banging', 400);")
    visit('/')
    expect(page).to have_content 'Manor House'
    expect(page).to have_content 'Mega Pad'
  end
end
