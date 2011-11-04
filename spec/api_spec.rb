require 'net/http'
require 'instadroid-server'

describe "apache" do
  it "must be running on port 80" do
    expect { Net::HTTP.get "127.0.0.1", "/index.html", 80 }.
      to_not raise_error(Errno::ECONNREFUSED)
  end
end