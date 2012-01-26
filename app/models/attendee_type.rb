class AttendeeType

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has n, :attendees

  def to_param
    [id, name.to_slug].join('-')
  end

end
