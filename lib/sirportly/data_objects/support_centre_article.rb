module Sirportly
  class SupportCentreArticle < DataObject
    self.collection_path = 'support_centres/articles'
    
    def self.find(client, query, support_centre_id, topic_id)
      results = client.request('support_centres/articles', :support_centre => support_centre_id, :topic => topic_id)['records']
      result = results.select { |article| article['id'] == query.to_i }.first
      self.new(client, result)
    end
    
    def self.search(client, query, support_centre_id, topic_id)
      results = client.request('support_centres/articles', :support_centre => support_centre_id, :topic => topic_id)['records']
      result = results.select { |article| 
        article.select { |key, value| value == query } != {} 
      }.first
      self.new(client, result) if result
    end

  end
end
