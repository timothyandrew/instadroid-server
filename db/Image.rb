class Image
  include DataMapper::Resource

  property :id,        Serial
  property :path,      Text, :required => true

  belongs_to :user

  validates_with_method :image_exists?

  def image_exists?
    if FileTest.exists?("#{path}")
      true
    else
      [ false, "Image doesn't exist." ]
    end
  end
end