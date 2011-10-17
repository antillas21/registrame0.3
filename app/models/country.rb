class Country

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :index => true
  
  validates_presence_of :name
  
  has n, :attendees
  
end
