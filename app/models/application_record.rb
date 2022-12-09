class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true # this is different in rails 7 and rails 6
end
