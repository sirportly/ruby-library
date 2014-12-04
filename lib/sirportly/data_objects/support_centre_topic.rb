module Sirportly
  class SupportCentreTopic < DataObject
    self.collection_path = 'support_centres/topics'

    def self.find(client, query, support_centre)
      results = client.request("support_centres/topics", :support_centre => support_centre)['records']
      result = results.select { |topic| topic['id'] = query.to_i }.first
      result['support_centre'] = support_centre
      self.new(client, result)
    end

    def self.search(client, query, support_centre)
      results = client.request("support_centres/topics", :support_centre => support_centre)['records']
      result = results.select { |topic| 
        topic.select { |key, value| value == query } != {} 
      }.first
      if result
        result['support_centre'] = support_centre
        self.new(client, result)
      end
    end    

    def articles
      result = client.request('support_centres/articles', :support_centre => attributes['support_centre'], :topic => attributes['id'])
      result['records'].map { |article| SupportCentreArticle.new(client, article) }
    end

    def article(query)
      SupportCentreArticle.find(client, query, attributes['support_centre'], attributes['id'])
    end

    def add_article(params = {})
      params.merge!({:support_centre => self.attributes['support_centre'], :topic => self.attributes['id']})
      if req = @client.request('support_centres/add_article', params)
        SupportCentreArticle.new(@client, req)
      else
        false
      end
    end

  end
end
