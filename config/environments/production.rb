Caliburn::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += ['blueprint/screen.css']

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'www.caliburnentertainment.co.uk' }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  
  config.middleware.use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[Exception] ",
      :sender_address => %{"Exception Notifier" <errors@caliburnentertainment.co.uk>},
      :exception_recipients => %w{whitby3001@gmail.com}
    }
    
  
  PAYPAL_URL = "https://www.paypal.com/cgi-bin/webscr"
  PAYPAL_EMAIL = ENV['PAYPAL_EMAIL']
  PAYPAL_CERT_ID = ENV['PAYPAL_CERT_ID']
  PAYPAL_SECRET = ENV['PAYPAL_SECRET']
  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/live_paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")
end
