class App < Framework
  def setup
    get '/' do |env|
      [200, {"Content-Type" => "text/html"}, "hello world!"]
    end

    get :default do

    end
  end
end