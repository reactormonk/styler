$LOAD_PATH.unshift(File.expand_path("#{__FILE__}/../../lib")) # Add PROJECT/lib to $LOAD_PATH
require 'stylist'
require 'ruby-debug'

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
    include Stylist::Style
    style_for Model::Foo
    association :foo
    association :fooz
    delegate :hello
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
    include Stylist::Style
    style_for Model::Bar::Foo
    def context; {}; end
  end
end
module Model
  class Baz
  end
end
