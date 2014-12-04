module Sirportly
  class SupportCentreTopic < DataObject
    self.collection_path = 'support_centres/topics'

    def self.find(client, query, support_centre_id)
      results = client.request(collection_path, :support_centre => support_centre_id)['records']
      result = results.select { |topic| topic['id'] = query.to_i }.first
      result['support_centre_id'] = support_centre_id
      self.new(client, result)
    end

    def self.search(client, query, support_centre_id)
      results = client.request(collection_path, :support_centre => support_centre_id)['records']
      result = results.select { |topic| 
        topic.select { |key, value| value == query } != {} 
      }.first
      if result
        result['support_centre_id'] = support_centre_id
        self.new(client, result)
      end
    end    

    def articles
      result = client.request(SupportCentreArticle.collection_path, :support_centre => attributes['support_centre_id'], :topic => attributes['id'])
      result['records'].map { |article| SupportCentreArticle.new(client, article) }
    end

    def article(query)
      SupportCentreArticle.find(client, query, attributes['support_centre_id'], attributes['id'])
    end

    def add_article(params = {})
      params.merge!({:support_centre => self.attributes['support_centre_id'], :topic => self.attributes['id']})
      if req = @client.request('support_centres/add_article', params)
        SupportCentreArticle.new(@client, req)
      else
        false
      end
    end

  end
end
