require 'rango/mixins/rendering'
require 'styler'
module Styler
  module Style
    include Rango::Helpers
    include Rango::ImplicitRendering
  end
end

module Rango::Helpers
  def style(model)
    Styler.new_style_for(model)
  end
end
