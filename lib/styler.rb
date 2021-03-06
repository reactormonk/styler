require_relative 'styler/style'
module Styler
  STYLES = {}

  def new_style_for(model, context={})
    if model.respond_to? :map
      model.map {|ele| model_to_style(ele, context)}
    else
      model_to_style(model, context)
    end
  end

  private

  def model_to_style(model, context)
    (style = STYLES[model.class]) ? style.new(model, context) : model
  end

  extend self
end
