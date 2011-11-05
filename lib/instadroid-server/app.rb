require 'data_mapper'
require './db/Image'
require './db/User'
require './db/helpers'
require './db/migrations'
require 'haml'

class App < Framework
  def setup
    DataMapper.setup(:default, 'postgres://localhost/postgres')
    DataMapper.finalize
    DataMapper.auto_migrate!
    DB.migrate
  end

  def create_routes
    get '/' do |env|
      user = User.get(1)
      image = user.images.first

      @engine = Haml::Engine.new(File.new(Dir.pwd+"/static/haml/single_image.haml").read)
      haml_vars = {:title => image.title || "<no title>", :path => image.path, :username => user.username, :env => env, :desc => image.description}
      [200, {"Content-Type" => "text/html"}, @engine.render(Object.new, haml_vars)]
    end

    get /\/public\/?.*\/abc/ do |env|
      [200, {"Content-Type" => "text/html"}, "Public"]
    end

    get :default do |env|
      [200, {"Content-Type" => "text/html"}, env.to_s]
    end
  end
end