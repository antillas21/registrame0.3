class Label

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :index => true
  property :width, Float, :required => true, :index => true
  property :height, Float, :required => true, :index => true
  property :top, Float, :default => 0.125
  property :bottom, Float, :default => 0.125
  property :left, Float, :default => 0.125
  property :right, Float, :default => 0.125
  property :font_size, Integer, :default => 14
  
  validates_presence_of :name, :width, :height

  def to_param
    [id, name.to_slug].join('-')
  end

end
