module Styler
  module RangoMixin
    module ClassMethods
    end

    module InstanceMethods
      def render(params)
        params.each do |key, value|
          params[key] = (::Styler.new_style_for(value) || value)
        end
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end

  module Style
    module InstanceMethods
      include Rango::ExplicitRendering
    end
  end
end
