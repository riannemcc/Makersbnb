require 'pg'


class Database

  def self.setup(dbname)
    uri = URI.parse(ENV['DATABASE_URL'])
    @connection = PG.connect(uri)
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end
