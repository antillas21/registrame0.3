class Interest

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has n, :attendees, :through => Resource
end
