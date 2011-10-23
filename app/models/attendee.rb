class Attendee

  include DataMapper::Resource

  property :id, Serial
  property :first_name, String, :required => true, :index => [:full_name]
  property :last_name, String, :required => true, :index => [:full_name]
  property :email, String, :required => true, :index => true
  property :phone, String, :required => false
  property :address, String, :required => false
  property :city, String, :required => false
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email
  validates_numericality_of :phone, :allow_nil => true
  
  belongs_to :state, :required => false
  belongs_to :country, :required => false
  belongs_to :attendee_type, :required => false
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
  def to_param
    "#{id}-#{url_name(first_name)}-#{url_name(last_name)}".downcase
  end
  
  def url_name(field)
    field.gsub(/[^a-z0-9]+/i, '-').gsub(/-+$/i, '')
  end
  
end
