module Sirportly
  class KnowledgeBase

    attr_accessor :id
    
    class << self
      def list
        Request.request('knowledge/list')
      end

      def find_by_id(id)
        tree = Request.request('knowledge/tree', :kb => id)
        self.new(id, tree = tree)
      rescue Errors::NotFound
        false
      end
    end

    def initialize(id, tree = nil)
      @id = id
      @tree = tree
    end

    def page(path)
      request('page', :path => path)
    end

    def tree
      @tree ||= request('tree')
    end

    def add_page(options = {})
      request('add_page', options)
    end

    def edit_page(path, options = {})
      options[:path] = path
      request('edit_page', options)
    end

    def delete_page(path)
      request('delete_page', :path => path)
    end
    
    private

    def request(path, options = {})
      options[:kb] = self.id
      Request.request('knowledge/'+path, options)
    end

  end
end
