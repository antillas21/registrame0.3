class Company

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 200, :required => true, :index => true
  # property :address, String, :length => 200
  # property :city, String, :length => 200, :required => true, :index => true
  
  validates_presence_of :name
  
  has n, :attendees

  def to_param
    "#{id}-#{url_name(name)}".downcase
  end
  
  def url_name(field)
    field.gsub(/[^a-z0-9]+/i, '-').gsub(/-+$/i, '')
  end

end
