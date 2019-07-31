def sign_up
  visit '/'
  fill_in('name', with: 'Sayonara')
  fill_in('email', with: 'test@example.com')
  fill_in('password', with: 'password123')
  fill_in('password_confirmation', with: 'password123')
  click_button('Sign up')
end

def list_property
  visit('/list_property')
  fill_in('name', with: 'Granny Annexe')
  fill_in('description', with: 'Old')
  fill_in('price', with: 20000)
  click_button('Enter')
end

def book_property
  click_button('Manor House')
  visit("/book_property")
  fill_in('name', with: 'Joshy')
  fill_in('email', with: 'joshy@josh.co.uk')
  fill_in('number', with: '00998877665')
  fill_in('start_date', with: '23-06-2020')
  fill_in('end_date', with: '29-06-2020')
  click_button('Submit')
end
