require 'data_mapper'
require './db/Image'
require './db/User'
require './db/helpers'
require './db/migrations'

class App < Framework
  def setup
    DataMapper.setup(:default, 'postgres://localhost/postgres')
    DataMapper.finalize
    DataMapper.auto_migrate!
    DB.migrate
  end

  def create_routes
    get '/' do |env|
      [200, {"Content-Type" => "text/html"}, "hello world"]
    end

    get :default do
      [200, {"Content-Type" => "text/html"}, "hello all"]
    end
  end
end