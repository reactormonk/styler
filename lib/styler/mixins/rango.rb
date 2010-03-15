require 'rango/mixins/rendering'
require 'styler'
module Styler
  module Style
    include Rango::Helpers
    include Rango::ImplicitRendering
  end
end

module Styler
  module RangoMixin
    include Rango::ImplicitRendering
    def render(template, *models)
      models.each {|name|
        instance_variable_set(
          "@#{name}",
          ::Styler.new_style_for(
            instance_variable_get("@#{name}"),
            {__controller: self}
          )
        )
      }
      super(template)
    end
  end
end

