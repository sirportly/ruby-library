require 'uri'
require 'net/https'
require 'json'

require 'sirportly/request'
require 'sirportly/ticket'
require 'sirportly/objects'

module Sirportly
  class << self
    
    ## Returns the current version number for the Sirportly API client.
    def version
      "1.0.0-beta"
    end
    
    ## Stores authentication details
    attr_accessor :token
    attr_accessor :secret
    
    ## Allow the domain to be changed
    attr_writer :domain
    
    ## Returns the domain which should be used to query the API
    def domain
      @domain ||= 'https://app.sirportly.com'
    end
    
  end
  
  ## Various error classes to raise
  class Error < StandardError; end
  module Errors
    class ServiceUnavailable < Error; end
    class AccessDenied < Error; end
    class NotFound < Error; end
    class CommunicationError < Error; end
  end
  
end
