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
          define_method(m) { |*args|
            @model.send(m, *args)
          }
        end
      end

      def delegate_to_controller(*methods)
        methods.each do |m|
          define_method(m) { |*args|
            @__controller.send(m, *args)
          }
        end
      end

      def style_for(model)
        model.instance_methods.each do |method|
          unless method_defined? method
            define_method(method) {|*args| @model.send(method, *args)}
          end
        end
        Styler::STYLES.merge!({model => self})
      end
    end

    module InstanceMethods
      def initialize(model, context={})
        serialize_from_hash(context)
        @model = model
        @__type ||= :default
      end

      attr_reader :model, :request

      # Use like style.as(:widget)
      def as(type)
        @__type = type
        self
      end

      # Use this method to add something to the context
      def with(context)
        serialize_from_hash(context)
        self
      end

      # This is the final hook, define :prepare if you need to add some stuff
      # Set @template_path if you want a custom path.
      def to_s
        prepare if respond_to?(:prepare)
        render(@template_path || compile_template_path)
      end

      # This method compiles the default template path.
      def compile_template_path
        "#{__class__.to_s.downcase.gsub('::','/')}/#{@__type}"
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
      receiver.delegate_to_controller :request
    end
  end
end
