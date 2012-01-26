class Company

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 200, :required => true, :index => true
  
  validates_presence_of :name
  
  has n, :attendees

  def to_param
    [id, name.to_slug].join('-')
  end

end
