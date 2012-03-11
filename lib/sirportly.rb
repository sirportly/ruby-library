require 'time'
require 'uri'
require 'net/https'
require 'json'

require 'sirportly/client'
require 'sirportly/request'
require 'sirportly/data_set'
require 'sirportly/data_object'

require 'sirportly/data_objects/brand'
require 'sirportly/data_objects/customer'
require 'sirportly/data_objects/customer_contact_method'
require 'sirportly/data_objects/department'
require 'sirportly/data_objects/escalation_path'
require 'sirportly/data_objects/priority'
require 'sirportly/data_objects/filter'
require 'sirportly/data_objects/sla'
require 'sirportly/data_objects/status'
require 'sirportly/data_objects/team'
require 'sirportly/data_objects/user'

module Sirportly
  class << self
    
    ## Returns the current version number for the Sirportly API client.
    def version
      "1.1.0"
    end
    
    ## Stores the application token if one has been provided. This can be nil if no
    ## application token exists, however if nil, you cannot authenticate using user
    ## tokens.
    attr_accessor :application
    
    ## Allow the domain to be changed
    attr_writer :domain
    
    ## Returns the domain which should be used to query the API
    def domain
      @domain ||= 'https://api.sirportly.com'
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
