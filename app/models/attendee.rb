class Attendee

  include DataMapper::Resource

  property :id, Serial
  property :first_name, String, :length => 80, :required => true, :index => [:full_name]
  property :last_name, String, :length => 80, :required => true, :index => [:full_name]
  property :email, String, :length => 80, :required => true, :unique => true, :index => true
  property :phone, String, :required => false
  property :job, String, :length => 100
  property :address, String, :length => 100, :required => false
  property :city, String, :required => false, :index => [:city]
  property :printed, Boolean, :default => false, :index => true
  
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :as => :email_address
  # validates_numericality_of :phone, :allow_nil => true, :allow_blank => true
  
  belongs_to :state, :required => false
  belongs_to :country, :required => false
  belongs_to :attendee_type, :required => false
  belongs_to :company, required: false
  
  has n, :interests, :through => Resource

  def full_name
    [first_name, last_name].join(' ')
  end
  
  def to_param
    [id, first_name.to_slug, last_name.to_slug].join('-')
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
    self.attendee_type = AttendeeType.first_or_create(name: name) unless name.blank?
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
