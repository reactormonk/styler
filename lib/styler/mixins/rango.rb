require 'rango/mixins/rendering'
require 'styler'
module Styler
  module Style
    module InstanceMethods
      include Rango::ImplicitRendering
    end
  end
end

module Styler
  module RangoMixin
    include Rango::ImplicitRendering
    def render(template, *models)
      @__controller = self
      models.each {|name|
        instance_variable_set("@#{name}",::Styler.new_style_for(instance_variable_get("@#{name}")))
      }
      super
    end
  end
end

