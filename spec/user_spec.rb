require 'user'

describe User do

  describe '.create' do
    it 'creates a new user' do
      user_id = User.create(name: 'name', email: 'test@example.com', password: 'password123')

      user = Database.connection.query("SELECT * FROM users WHERE id = #{user_id};")

      expect(user.first['id']).to eq user_id
      expect(user.first['name']).to eq 'name'
      expect(user.first['email_address']).to eq 'test@example.com'
      expect(user.first['password']).to eq 'password123'
    end
  end
end
