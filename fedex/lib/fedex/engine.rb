require_relative 'sessions'
require_relative 'rates'

module Fedex
  class Engine < ::Rails::Engine
    isolate_namespace Fedex
  end

  module Sessions
    def self.authenticate_token
      jorge_ortiz
    end
  end

  module Rates
    def self.shipping_rates
      set_rates
    end
  end
end
