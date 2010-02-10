module Styler
  module Style
    module ClassMethods
      # Add all the methods that will call other model instances here.
      # As there are no collection-styles, set up complicated stuff in :prepare
      def association(*methods)
        methods.each do |m|
          define_method(m) {|*args, &block|
            assoc = @model.send(m, *args, &block)
            ::Styler.new_style_for(assoc,serialize_to_hash.merge({@model.class.to_s.downcase.split('::').last => self}))
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
        Styler::STYLES.merge!({model => self})
      end
    end
  
    module InstanceMethods
      def initialize(model, context={})
        serialize_from_hash(context)
        @model = model
        @type ||= :default
      end

      attr_reader :model

      # Use like style.as(:widget)
      def as(type)
        @type = type
        self
      end

      # Use this method to add something to the context
      def with(context)
        serialize_from_hash(context)
        self
      end

      # This is the final hook, define :prepare if you need to add some stuff
      # Set @template if you want a custom path.
      def to_s
        prepare if respond_to?(:prepare)
        render @template || compile_template_path
      end

      # This method compiles the default template path.
      def compile_template_path
        "#{__class__.to_s.downcase.gsub('::','/')}/#{@type}"
      end

      alias_method :__class__, :class
      # I don't like this, but it's needed for routers that check the class if
      # you use resource-based routers (like CRUDtree).
      def class
        @model.class
      end

      private
      def serialize_from_hash(hash)
        hash.each {|key,value|
          name = (key.to_s =~ /^@/) ? key.to_s : "@#{key}"
          instance_variable_set(name, value)
        }
      end

      def serialize_to_hash
        Hash[instance_variables.map {|name| [name, instance_variable_get(name)]}]
      end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
