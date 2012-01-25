module Sirportly
  class Objects
    class << self
      
      def statuses
        Request.request('objects/statuses')
      end
      
      def priorities
        Request.request('objects/priorities')
      end
      
      def users
        Request.request('objects/users')
      end
      
      def teams
        Request.request('objects/teams')
      end
      
      def brands
        Request.request('objects/brands')
      end
      
      def departments(brand_id = nil)
        if brand_id
          begin
            Request.request('objects/departments', :brand_id => brand_id.to_i)
          rescue Errors::NotFound
            false
          end
        else
          Request.request('objects/departments')
        end
      end
      
      def escalation_paths
        Request.request('objects/escalation_paths')
      end
      
      def slas
        Request.request('objects/slas')
      end
      
    end
  end
end
