require 'dm-rails/middleware/identity_map'
class ApplicationController < ActionController::Base
  use Rails::DataMapper::Middleware::IdentityMap
  protect_from_forgery

  helper_method :set_badge_cookies, :set_format_cookies

  def set_badge_cookies
    prefs = Preference.first
    
    cookies[:qrcode] = prefs.create_qrcode
    cookies[:label] = prefs.print_label

    cookies[:label_contents] = prefs.label_options.to_hash.keys
    cookies[:qrcode_contents] = prefs.qrcode_options.to_hash.keys
  end

  def set_format_cookies
    label = Label.first

    cookies[:label_format] = [label.width, label.height]
    cookies[:label_margins] = [label.top, label.left, label.right, label.bottom]
    cookies[:label_font_size] = label.font_size
  end
end
