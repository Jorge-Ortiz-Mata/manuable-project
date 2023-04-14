module Manuable
  module Gem
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
