require 'uri'
require 'net/https'
require 'json'

require 'sirportly/request'
require 'sirportly/data_object'

require 'sirportly/data_objects/brand'
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
    
    ## Stores authentication details
    attr_accessor :token
    attr_accessor :secret
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

Sirportly.token = 'dfc75dc1-ce49-1b02-e4ca-900d6673e6d4'
Sirportly.secret = 'lpodkv4ofptamtlqn0ruxvtg1f1ndvjik9o7zdgbmv88zn9du3'
