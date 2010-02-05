$LOAD_PATH.unshift(File.expand_path("#{__FILE__}/../../lib")) # Add PROJECT/lib to $LOAD_PATH
require 'stylist'
require 'ruby-debug'

module Model
  class Foo
  end
end
module Style
  class Foo
    include Stylist::Style
    style_for Model::Foo
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
  end
end
module Model
  class Baz
  end
end
