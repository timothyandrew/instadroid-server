class Framework 
  attr_reader :path_hashes

  def initialize
    @path_hashes = {:GET => {}, :POST => {}}
  end
end