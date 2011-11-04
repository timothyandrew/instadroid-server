class App < Framework
  def setup
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