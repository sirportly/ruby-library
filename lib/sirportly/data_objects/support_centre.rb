module Sirportly
  class SupportCentre < DataObject
    self.collection_path = 'support_centres/list'

    def self.find(client, query)
      result = client.request(collection_path)['records'].select { |support_centre| support_centre['id'] == query.to_i }.first
      self.new(client, result) if result
    end

    def self.search(client, query)
      result = client.request(collection_path)['records'].select { |support_centre| 
        support_centre.select { |key, value| value == query} != {} 
      }.first
      self.new(client, result) if result
    end

    ## request an auth token for support centre, allowing to authenticate a user
    def auth_token(opts = {})
      if req = client.request_v2('authentication/support_centre_token', opts.merge(:support_centre => self.id))
        req
      else
        false
      end
    end

    def redirect_uri(support_centre_token, return_to = nil)
      support_centre_token = if support_centre_token.is_a?(Hash)
                               support_centre_token['token']
                             end

      URI::HTTP.build([nil, self.access_domain, nil, ['/login', support_centre_token].join('/'), return_to ? "return_to=#{return_to}" : nil, nil]).to_s
    end

    def topics
      result = client.request( SupportCentreTopic.collection_path, :support_centre => attributes['id'])
      result['records'].map { |topic| topic['support_centre_id'] = attributes['id']; SupportCentreTopic.new(client, topic) }
    end

    def topic(query)
      SupportCentreTopic.find(client, query, self.id)
    end

    def add_topic(params = {})
      params.merge!({:support_centre => self.attributes['id']})
      if req = @client.request('support_centres/add_topic', params)
        SupportCentreTopic.new(@client, req)
      else
        false
      end
    end

  end
end
