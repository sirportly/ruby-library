module Sirportly
  class Brand < DataObject
    self.api_path = 'objects/brands'
    self.maps = {'departments' => "Department"}
  end
end
