Shadowmsg::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  ENV["REDISTOGO_URL"] = 'redis://redistogo:23d7d203566bda6a96f1a31cbe3d9f1f@hoki.redistogo.com:9911/'
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  # General Settings
  config.app_domain = 'shadowmsg.herokuapp.com'
  

  # Email
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: config.app_domain }
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com', 
    port: '587',
    enable_starttls_auto: true,
    user_name: 'someuser',
    password: 'somepass',
    authentication: :plain,
    domain: 'shadowmsg.herokuapp.com'
  }
end
