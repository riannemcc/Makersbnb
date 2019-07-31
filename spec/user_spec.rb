require 'user'

describe User do

  describe '.create' do
    it 'creates a new user' do
      user_id = User.create(name: 'name', email: 'test@example.com', password: 'password123')

      user = Database.connection.query("SELECT * FROM users WHERE id = #{user_id};")

      expect(user.first['id']).to eq user_id
      expect(user.first['name']).to eq 'name'
      expect(user.first['email_address']).to eq 'test@example.com'
    end
  end

  describe'.authenticate' do
    it 'returns a user given a correct username and password if one exists' do
      user = User.create(name: 'name', email: 'test@example.com', password: 'password123')

      expect(User.authenticate(email: 'notright@gmail.com', password: 'password123')).to eq (-1)
    end
  end
end
