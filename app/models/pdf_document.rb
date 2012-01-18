class PdfDocument
  require 'prawn/measurement_extensions'

  attr_accessor :width, :height, :top, :left, :right, :bottom, :font_size, :contents_hash

  def initialize(width_height, margins, font_size)
    label_size = Array(width_height)
    label_margins = Array(margins)

    @width, @height = label_size[0], label_size[1]
    @top, @left, @right, @bottom = label_margins[0], label_margins[1], label_margins[2], label_margins[3]
    @font_size = font_size
    @contents_hash = {}
  end

  def create_label(attendee, qrcode = false, label_contents = [])
    @attendee = Attendee.get(attendee.id.to_i)
    @pdf = Prawn::Document.new(
      page_size: [@width.in, @height.in], top_margin: @top.in, left_margin: @left.in, right_margin: @right.in,
      bottom_margin: @bottom.in, font_size: @font_size
    )
    build_contents_hash(@attendee, qrcode, label_contents)
    populate_pdf
    render_pdf
  end

  def build_contents_hash(attendee, qrcode = false, label_contents = [])
    @contents_hash[:attendee_url] = attendee.to_param
    fetch_text_elements(attendee, label_contents)
  end

  def fetch_text_elements(attendee, label_contents = [])
    @contents_hash[:label_elements] = []
    label_contents.each do |field|
      @contents_hash[:label_elements] << attendee.send(field.to_sym) unless attendee.send(field.to_sym).blank?
    end
  end

  def populate_pdf
    @contents_hash[:label_elements].each do |line|
      @pdf.text line, align: :center, size: @font_size
    end
  end

  def render_pdf
    @pdf.render_file "#{Rails.root.to_s}/public/uploads/labels/#{@contents_hash[:attendee_url]}.pdf"
  end
end
