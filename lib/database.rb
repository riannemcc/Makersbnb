require 'pg'

class Database

  def self.setup(dbname)
    if ENV['ENVIRONMENT'] == 'test'
    @connection = PG.connect(dbname: "#{dbname}_test")
    else
    @connection = PG.connect(dbname: dbname)
    end
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end
