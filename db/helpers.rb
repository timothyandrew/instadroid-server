module DB
  module Helpers
    def self.new_salt
      (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
    end
  end
end