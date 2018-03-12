require 'time'
require 'uri'
require 'net/https'
require 'json'

require 'net/http/post/multipart'

require 'sirportly/client'
require 'sirportly/request'
require 'sirportly/data_set'
require 'sirportly/data_object'
require 'sirportly/spql_query'
require 'sirportly/extensions'

require 'sirportly/data_objects/api_token'
require 'sirportly/data_objects/brand'
require 'sirportly/data_objects/customer'
require 'sirportly/data_objects/customer_contact_method'
require 'sirportly/data_objects/custom_field'
require 'sirportly/data_objects/department'
require 'sirportly/data_objects/escalation_path'
require 'sirportly/data_objects/facebook_page'
require 'sirportly/data_objects/filter'
require 'sirportly/data_objects/knowledge_base'
require 'sirportly/data_objects/knowledge_base_page'
require 'sirportly/data_objects/priority'
require 'sirportly/data_objects/sla'
require 'sirportly/data_objects/status'
require 'sirportly/data_objects/team'
require 'sirportly/data_objects/ticket'
require 'sirportly/data_objects/ticket_update'
require 'sirportly/data_objects/twitter_account'
require 'sirportly/data_objects/user'

module Sirportly
  VERSION = '1.4.4'

  class << self

    ## Stores the application token if one has been provided. This can be nil if no
    ## application token exists, however if nil, you cannot authenticate using user
    ## tokens.
    attr_accessor :application

    ## Specifies whether or not to execute rules when running API calls. By default,
    ## all rules will be run. Set to false to stop execution.
    attr_accessor :execute_rules

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
    class ValidationError < Error; end
  end

end
