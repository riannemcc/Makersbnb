require 'database'
describe Database do

  describe '#setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: '?')

      Database.setup('?')
    end

    it 'this connection is persisent' do
      connection = Database.setup('?')
      expect(Database.connection).to eq connection
    end
  end
end
