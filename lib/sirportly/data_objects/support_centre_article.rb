module Sirportly
  class SupportCentreArticle < DataObject
    self.collection_path = 'support_centres/articles'
    
    def self.find(client, query, support_centre, topic)
      results = client.request("support_centres/articles", :support_centre => support_centre, :topic => topic)['records']
      result = results.select { |article| 
        article.select { |key, value| value == query } != {} 
      }.first
      self.new(client, result) if result
    end

  end
end
