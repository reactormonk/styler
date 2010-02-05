$LOAD_PATH.unshift(File.expand_path("#{__FILE__}/../../lib")) # Add PROJECT/lib to $LOAD_PATH
require 'stylist'
require 'ruby-debug'

class ::Foo; end
module ::Stylist; class Foo; def initialize(*args); end; end; end
module ::Bar; class Foo; end; end
module ::Stylist; module Bar; class Foo; def initialize(*args); end; end; end; end
module ::Bar; class Baz; end; end
