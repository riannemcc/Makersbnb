require 'database'
describe Database do

  describe '#setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'makersbnb_test')

      Database.setup('makersbnb_test')
    end

    it 'this connection is persisent' do
      connection = Database.setup('makersbnb_test')
      expect(Database.connection).to eq connection
    end
  end
end
