$LOAD_PATH.unshift(File.expand_path("#{__FILE__}/../../lib")) # Add PROJECT/lib to $LOAD_PATH
require 'styler'
require 'ruby-debug'

# I don't like adding dependencies if I don't need to :-)
module Styler::Style
  module InstanceMethods
    def render(*args)
      [ args,
        Hash[instance_variables.map {|name| [name, instance_variable_get(name)]} ]
      ]
    end
  end
end

module Model
  class Foo
    def foo
      Model::Bar::Foo.new
    end
    def fooz
      [Model::Bar::Foo.new, Model::Bar::Foo.new]
    end
    def hello
      :hello
    end
  end
end
module Style
  class Foo
    include Styler::Style
    style_for Model::Foo
    association :foo
    association :fooz
    def context; {}; end
  end
end
module Model
  module Bar
    class Foo
    end
  end
end
module Style
  class Bar
    include Styler::Style
    style_for Model::Bar::Foo
  end
end
module Model
  class Baz
  end
end
