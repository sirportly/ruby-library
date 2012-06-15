module Sirportly
  class KnowledgeBase < DataObject
    
    self.collection_path = 'knowledge/list'
    
    def self.find(client, query)
      result = client.request("knowledge/list").select { |i| i['id'] == query.to_i}.first
      self.new(client, result)
    end
    
    def page(path)
      KnowledgeBasePage.new(client, client.request('knowledge/page', :kb => attributes['id'], :path => path))
    end
    
    def tree
      client.request('knowledge/tree', :kb => attributes['id']).map { |i| KnowledgeBasePage.new(client, i) }
    end
    
    def create_page(params = {})
      params.merge!({:kb => self.attributes['id']})
      if req = @client.request('knowledge/add_page', params)
        KnowledgeBasePage.new(@client, req)
      else
        false
      end
    end
    
  end
end