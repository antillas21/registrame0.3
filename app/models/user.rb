class User

  include DataMapper::Resource
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_reader :password, :current_password
  attr_accessor :password_confirmation, :current_password
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  property :id, Serial
  property :login, String, :required => true, :index => [:user_combo]
  property :email, String, :required => true, :index => [:user_combo]
  
  validates_presence_of :login
  validates_format_of :email, :with => EmailRegex

end
