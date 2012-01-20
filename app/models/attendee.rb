class Attendee

  include DataMapper::Resource

  property :id, Serial
  property :first_name, String, :required => true, :index => [:full_name]
  property :last_name, String, :required => true, :index => [:full_name]
  property :email, String, :required => true, :index => true
  property :phone, String, :required => false
  property :address, String, :required => false
  property :city, String, :required => false, :index => [:city]
  property :printed, Boolean, :default => false, :index => true
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email
  validates_numericality_of :phone, :allow_nil => true, :allow_blank => true
  
  belongs_to :state, :required => false
  belongs_to :country, :required => false
  belongs_to :attendee_type, :required => false
  belongs_to :company, required: false
  
  has n, :interests, :through => Resource

  def full_name
    [first_name, last_name].join(' ')
  end
  
  def to_param
    "#{id}-#{url_name(first_name)}-#{url_name(last_name)}".downcase
  end
  
  def url_name(field)
    field.gsub(/[^a-z0-9]+/i, '-').gsub(/-+$/i, '')
  end

  def company_name
    self.company.name if company
  end

  def company_name=(name)
    self.company = Company.first_or_create(name: name) unless name.blank?
  end

  def country_name
    self.country.name if country
  end

  def country_name=(name)
    self.country = Country.first_or_create(name: name) unless name.blank?
  end

  def state_name
    self.state.name if state
  end

  def state_name=(name)
    self.state = State.first_or_create(name: name) unless name.blank?
  end

  def registration_type
    self.attendee_type.name if attendee_type
  end

  def registration_type=(id)
    self.attendee_type = AttendeeType.first(id: id)
  end

  def registration=(name)
    self.attendee_type = AttendeeType.first_or_create(name: name)
  end

  def registration
    self.attendee_type.name if attendee_type
  end

  def self.printed_badges
    count(printed: true)
  end

  def self.printed
    all(printed: true)
  end
  
end
