source 'http://rubygems.org'

RAILS_VERSION = '~> 3.1.1'
DM_VERSION    = '~> 1.2.0'

gem 'activesupport',      RAILS_VERSION, :require => 'active_support'
gem 'actionpack',         RAILS_VERSION, :require => 'action_pack'
gem 'actionmailer',       RAILS_VERSION, :require => 'action_mailer'
gem 'railties',           RAILS_VERSION, :require => 'rails'

gem 'rails',              RAILS_VERSION
gem 'dm-rails',          '~> 1.2.0'
gem 'dm-mysql-adapter', DM_VERSION

gem 'jquery-rails'

# You can use any of the other available database adapters.
# This is only a small excerpt of the list of all available adapters
# Have a look at
#
#  http://wiki.github.com/datamapper/dm-core/adapters
#  http://wiki.github.com/datamapper/dm-core/community-plugins
#
# for a rather complete list of available datamapper adapters and plugins

# gem 'dm-sqlite-adapter',    DM_VERSION
# gem 'dm-mysql-adapter',     DM_VERSION
# gem 'dm-postgres-adapter',  DM_VERSION
# gem 'dm-oracle-adapter',    DM_VERSION
# gem 'dm-sqlserver-adapter', DM_VERSION

gem 'dm-migrations',        DM_VERSION
gem 'dm-types',             DM_VERSION
gem 'dm-validations',       DM_VERSION
gem 'dm-constraints',       DM_VERSION
gem 'dm-transactions',      DM_VERSION
gem 'dm-aggregates',        DM_VERSION
gem 'dm-timestamps',        DM_VERSION
gem 'dm-observer',          DM_VERSION
gem 'dm-serializer', '1.2.0'

gem "tzinfo"

gem 'devise', '> 1.4.6'
gem 'dm-devise', '~> 1.5.0.beta'
#gem 'dm-paperclip', '2.4.0'
gem 'dm-paperclip', :git => 'git://github.com/Snorby/dm-paperclip.git'
gem 'to_slug'

# templating
gem 'haml-rails', '~> 0.3.4'
gem 'haml'

gem 'json_builder', '3.0.2'
gem 'prawn'
gem 'prawn-qrcode'
gem 'rqrcode'
gem "elskwid-munger", "~> 0.1.4.5"

group :production do
  gem 'therubyracer'
end

group :assets do
  gem 'sass-rails',   "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group(:development, :test) do

  # Uncomment this if you want to use rspec for testing your application

  # gem 'rspec-rails', '~> 2.0.1'
  gem 'rspec-rails', '~> 2.6.1'
  gem 'mocha',       '~> 0.10.0'
  gem 'timecop',     '~> 0.3.5'
  
  gem 'factory_girl_rails'
  gem 'capistrano'

  # To get a detailed overview about what queries get issued and how long they take
  # have a look at rails_metrics. Once you bundled it, you can run
  #
  #   rails g rails_metrics Metric
  #   rake db:automigrate
  #
  # to generate a model that stores the metrics. You can access them by visiting
  #
  #   /rails_metrics
  #
  # in your rails application.

  # gem 'rails_metrics', '~> 0.1', :git => 'git://github.com/engineyard/rails_metrics'

end

