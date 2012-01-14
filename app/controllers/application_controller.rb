require 'dm-rails/middleware/identity_map'
class ApplicationController < ActionController::Base
  use Rails::DataMapper::Middleware::IdentityMap
  protect_from_forgery

  helper_method :set_badge_cookies

  def set_badge_cookies
    prefs = Preference.first
    cookies[:qrcode] = prefs.create_qrcode
    cookies[:label] = prefs.print_label
  end
end
