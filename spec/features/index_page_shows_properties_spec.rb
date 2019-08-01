require 'pg'
require 'database_setup'

feature 'Testing index page' do
  scenario 'index page returns properties' do

    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Manor House', 'Lovely house', 200);")
    Database.query("INSERT INTO properties (property_name, description, price) VALUES('Mega Pad', 'Banging', 400);")
    visit('/index')
    expect(page).to have_content('Manor House')
    expect(page).to have_content('Mega Pad')
  end
end
