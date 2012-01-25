class PdfDocument
  require 'prawn/measurement_extensions'
  require 'prawn/qrcode'
  require 'rqrcode'

  attr_accessor :width, :height, :top, :left, :right, :bottom, :font_size, :contents_hash

  def initialize(width_height, margins, font_size)
    label_size = Array(width_height)
    label_margins = Array(margins)

    @width, @height = label_size[0].to_f, label_size[1].to_f
    @top, @left, @right, @bottom = label_margins[0].to_f, label_margins[1].to_f, label_margins[2].to_f, label_margins[3].to_f
    @font_size = font_size
    @contents_hash = {}
  end

  def create_label(attendee, qrcode = false, label_contents = [], qrcode_contents = [])
    @attendee = Attendee.get(attendee.id.to_i)
    @pdf = Prawn::Document.new(
      page_size: [@width.in, @height.in], top_margin: @top.in, left_margin: @left.in, right_margin: @right.in,
      bottom_margin: @bottom.in, font_size: @font_size
    )
    build_contents_hash(@attendee, qrcode, label_contents, qrcode_contents)
    populate_pdf
    render_pdf
  end

  def build_contents_hash(attendee, qrcode = false, label_contents = [], qrcode_contents = [])
    @contents_hash[:attendee_url] = attendee.to_param
    fetch_text_elements(attendee, label_contents)
    if qrcode == "true"
      generate_qrcode(attendee, qrcode_contents)
    end
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
    @pdf.indent( ((@width * 72) - (@left * 72) - (@right * 72 ) - 140) / 2 ) { @pdf.render_qr_code(@contents_hash[:qrcode], dot: 2) } if @contents_hash[:qrcode].present?
  end

  def render_pdf
    @pdf.render_file "#{Rails.root.to_s}/public/uploads/labels/#{@contents_hash[:attendee_url]}.pdf"
  end

  def generate_qrcode(attendee, qrcode_contents = [])
    elements = {}
    qrcode_contents.each do |field|
      elements[field.to_sym] =  attendee.send(field.to_sym)
    end

    mecard_string = "MECARD:"
    mecard_string << "N:#{elements[:full_name].to_s};" if elements[:full_name].present?
    mecard_string << "TEL:#{elements[:phone].to_s};" if elements[:phone].present?
    mecard_string << "EMAIL:#{elements[:email].to_s};" if elements[:email].present?
    mecard_string << "ADR:#{elements[:address].to_s}" if elements[:address].present?
    mecard_string << ", #{elements[:city].to_s}" if elements[:city].present?
    mecard_string << ";" if elements[:address].present?
    mecard_string << "NOTE:#{elements[:company_name].to_s};" if elements[:company_name].present?
    mecard_string << ";"

    @contents_hash[:qrcode] = RQRCode::QRCode.new(mecard_string, level: :q, size: 12)
  end
end
