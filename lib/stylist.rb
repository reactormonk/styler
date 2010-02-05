#require_relative 'stylist/style'
module Stylist

  def new_stylist_for(model, context={})
    (style = style_for(model)) ? style.new(model, context) : nil
  end

  private

  # @param name<String> The name of the constant to get, e.g. "Merb::Router".
  #
  # @return <Object> The constant corresponding to the name.
  def full_const_get(name)
    list = name.split("::")
    list.shift if list.first.nil? || list.first.strip.empty?
    obj = self
    list.each do |x|
      # This is required because const_get tries to look for constants in the
      # ancestor chain, but we only want constants that are HERE
      obj = obj.const_defined?(x) ? obj.const_get(x) : obj.const_missing(x)
    end
    obj
  end

  def style_for(model)
    begin
      full_const_get(model.class.to_s)
    rescue NameError
      nil
    end
  end

  extend self
end
