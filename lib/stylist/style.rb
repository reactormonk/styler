module Stylist
  module Style
    module ClassMethods
      # Add all the methods that will call other model instances here.
      # As there are no collection-styles, set up complicated stuff in :prepare
      def association(*methods)
        methods.each do |m|
          define_method(m) {
            models = @model.send(m)
            if models.respond_to? :each
              models.map {|ele|
                Stylist.new_stylist_for(ele,context.merge({@model.class.to_s.downcase => self})) || ele
              }
            else
              Stylist.new_stylist_for(models, context.merge({@model.class.to_s.downcase => self})) || models
            end
          }
        end
      end

      def delegate(*methods)
        methods.each do |m|
          define_method(m) {
            @model.send(m)
          }
        end
      end

      def style_for(model)
        Stylist::STYLES.merge!({model => self})
      end
    end
  
    module InstanceMethods
      def initialize(model, context={})
        @model = model
        @type = :default
        @context = context
      end

      attr_reader :model

      # Use like style.as(:widget)
      def as(type)
        @type = type
        self
      end

      def with(context)
        @context.merge!(context)
        self
      end

      # This is the final hook, define :prepare if you need to add some stuff
      # to the @context.
      def to_s
        prepare if respond_to?(:prepare)
        @context.merge!(model: @model)
        render "stylist/#{__class__.to_s.gsub('::','/')}/#{@type}", @context
      end

      alias_method :__class__, :class
      # I don't like this, but it's needed for routers that check the class if
      # you use resource-based routers (like CRUDtree).
      def class
        @model.class
      end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
