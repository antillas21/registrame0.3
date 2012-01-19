Paperclip.configure do |config|
  config.root = Rails.root
  config.env = Rails.env
  config.use_dm_validations = true
end
