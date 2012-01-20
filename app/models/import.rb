class Import

  include DataMapper::Resource
  include DataMapper::Validate
  include Paperclip::Resource

  property :id, Serial
  property :name, String
  property :document_file_name, String, :length => 255
  property :document_content_type, String, :length => 255
  property :document_file_size, Integer
  property :document_updated_at, DateTime
  
  #has_attached_file :document, :path => 'public/uploads/documents/:attachment/:id/:style/:basename.:extension'
  has_attached_file :document, :styles => {}

  #validates_presence_of :document, :on => :create
  validates_attachment_presence :document
  validates_attachment_content_type :document, :content_type => 'text/csv'

  before :save do
    self.name = document_file_name
  end

end
