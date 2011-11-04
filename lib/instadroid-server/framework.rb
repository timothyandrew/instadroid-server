class Framework 
  attr_reader :path_hashes

  def initialize
    @path_hashes = {:GET => {}, :POST => {}}
  end

  def get(path, &block)
    @path_hashes[:GET][path] = block
  end

  def post(path, &block)
    @path_hashes[:POST][path] = block
  end

  def call(env)
    path = env["PATH_INFO"]
    method = env["REQUEST_METHOD"].intern

    begin
      @path_hashes[method][path].call env
    rescue NoMethodError
      begin
        @path_hashes[method][:default].call env
      rescue NoMethodError
        [404, {"Content-Type"=>"text/html"}, "Invalid URL"]
      end
    end
  end
end