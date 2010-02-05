require_relative 'stylist/style'
module Stylist
  STYLES = {}

  def new_stylist_for(model, context={})
    if (style = style_for(model))
      style.new(model, context)
    else
      nil
    end
  end

  private

  def style_for(model)
    STYLES[model.class]
  end

  extend self
end
