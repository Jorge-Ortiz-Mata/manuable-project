module Manuable
  module Gem
    class Engine < ::Rails::Engine
      isolate_namespace Manuable::Gem
    end
  end
end
