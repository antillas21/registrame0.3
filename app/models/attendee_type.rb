class AttendeeType

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has n, :attendees

  def to_param
    "#{id}-#{url_name(name)}".downcase
  end

  def url_name(field)
    field.gsub(/[^a-z0-9]+/i, '-').gsub(/-+$/i, '')
  end

end
