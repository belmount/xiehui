class Page < ActiveRecord::Base
  scope :path, ->(pathv){where(path: pathv ).first}
end
