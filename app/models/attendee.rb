class Attendee

  include DataMapper::Resource

  property :id, Serial
  property :first_name, String, :required => true, :index => [:full_name]
  property :last_name, String, :required => true, :index => [:full_name]
  property :email, String, :required => true, :index => true
  property :phone, String, :required => false
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email
  validates_numericality_of :phone, :allow_nil => true
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
end
