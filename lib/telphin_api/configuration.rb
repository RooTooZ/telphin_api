require 'logger'

module TelphinApi
  # General configuration module.
  #
  # @note `TelphinApi::Configuration` extends `TelphinApi` so these methods should be called from the latter.
  module Configuration
    # Available options.
    OPTION_NAMES = [
      :app_key,
      :app_secret,
      :site,
      :adapter,
      :faraday_options,
      :max_retries,
      :logger,
      :log_requests,
      :log_errors,
      :log_responses,
    ]
    
    attr_accessor *OPTION_NAMES
    
    alias_method :log_requests?,  :log_requests
    alias_method :log_errors?,    :log_errors
    alias_method :log_responses?, :log_responses
    
    # Default HTTP adapter.
    DEFAULT_ADAPTER = Faraday.default_adapter
    
    # Default HTTP verb for API methods.
    DEFAULT_HTTP_VERB = :post
    
    # Default max retries count.
    DEFAULT_MAX_RETRIES = 2
    
    # Logger default options.
    DEFAULT_LOGGER_OPTIONS = {
      requests:  true,
      errors:    true,
      responses: false
    }

    # Default url for site api
    DEFAULT_URL = 'https://pbx.telphin.ru/uapi'
    
    # A global configuration set via the block.
    # @example
    #   TelphinApi.configure do |config|
    #     config.adapter = :net_http
    #     config.logger  = Rails.logger
    #   end
    def configure
      yield self if block_given?
      self
    end
    
    # Reset all configuration options to defaults.
    def reset
      @site            = DEFAULT_URL
      @adapter         = DEFAULT_ADAPTER
      @faraday_options = {}
      @max_retries     = DEFAULT_MAX_RETRIES
      @logger          = ::Logger.new(STDOUT)
      @log_requests    = DEFAULT_LOGGER_OPTIONS[:requests]
      @log_errors      = DEFAULT_LOGGER_OPTIONS[:errors]
      @log_responses   = DEFAULT_LOGGER_OPTIONS[:responses]
    end
    
    # When this module is extended, set all configuration options to their default values.
    def self.extended(base)
      base.reset
    end
  end
end
