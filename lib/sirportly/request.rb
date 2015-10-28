module Sirportly
  class Request

    def self.request(client, path, data = {})
      req = self.new(client, path, :post)
      req.data = data
      req.make && req.success? ? req.output : false
    end

    attr_reader :path, :method, :client
    attr_accessor :data

    def initialize(client, path, method = :get)
      @path = path
      @method = method
      @client = client
    end

    def success?
      @success || false
    end

    def output
      @output || nil
    end

    def make
      uri = URI.parse([domain, "api/v1", @path].join('/'))
      http_request = http_req(uri, @data.stringify_keys)
      http_request.add_field("User-Agent", "SirportlyRubyClient/#{Sirportly::VERSION}")
      http_request.add_field("X-Auth-Token", @client.token)
      http_request.add_field("X-Auth-Secret", @client.secret)
      http_request.add_field("X-Sirportly-Rules", "disabled") if Sirportly.execute_rules == false

      if application
        http_request.add_field("X-Auth-Application", application)
      end

      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = ENV['NET_HTTP_OPEN_TIMOUT'] || 5

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      http_result = http.request(http_request)

      if http_result.body == 'true'
        @output = true
      elsif http_result.body == 'false'
        @output = false
      else
        @output = JSON.parse(http_result.body)
      end

      @success = case http_result
      when Net::HTTPSuccess
        true
      when Net::HTTPServiceUnavailable
        raise Sirportly::Errors::ServiceUnavailable
      when Net::HTTPForbidden, Net::HTTPUnauthorized
        puts http_result.body.inspect
        raise Sirportly::Errors::AccessDenied, "Access Denied for '#{@client.token}'"
      when Net::HTTPNotFound
        json = JSON.parse(http_result.body)
        raise Sirportly::Errors::NotFound, json['error']
      when Net::HTTPClientError
        json = JSON.parse(http_result.body)
        raise Sirportly::Errors::ValidationError, json['errors'].to_s
      else
        raise Sirportly::Errors::CommunicationError, http_result.body
      end
      self
    end

    private

    def http_req(uri, data)
      case @method
      when :post
        if data["file"]
          r = Net::HTTP::Post::Multipart.new(uri.request_uri, data)
        else
          r = Net::HTTP::Put.new(uri.request_uri)
          r.set_form_data(data)
        end

        return r
      when :put
        r = Net::HTTP::Put.new(uri.request_uri)
        r.set_form_data(data)
        return r
      when :delete
        r = Net::HTTP::Delete.new(uri.request_uri)
        r.set_form_data(data)
        return r
      else
        r = Net::HTTP::Get.new(uri.request_uri)
        r.set_form_data(data)
        return r
      end
    end

    def domain
      @client.opts[:domain] || Sirportly.domain
    end

    def application
      @client.opts[:application] || Sirportly.application
    end

  end
end
