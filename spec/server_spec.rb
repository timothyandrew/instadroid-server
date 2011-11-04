require 'net/http'

describe "server" do
  it "should be running on port 80" do
    expect { Net::HTTP.get "127.0.0.1", "/index.html", 80 }.
      to_not raise_error(Errno::ECONNREFUSED)
  end
end