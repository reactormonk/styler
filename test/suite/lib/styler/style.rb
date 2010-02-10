BareTest.suite do
  suite "Styler" do
    suite "Style" do
      suite "ClassMethods" do
        suite "#association" do
          setup :assoc, "a single association" do
            @styler = Styler.new_style_for(Model::Foo.new).foo
            @result_class = Style::Bar
          end
          setup :assoc, "an association collection" do
            @styler = Styler.new_style_for(Model::Foo.new).fooz
            @result_class = Style::Bar
          end
          assert "it maps models to stylers in :assoc" do
            if @styler.respond_to? :each
              @styler.all? {|style| equal(style.__class__,@result_class)}
            else
              equal(@styler.__class__, @result_class)
            end
          end
        end
        suite "#delegate" do
          setup do
            @styler = Styler.new_style_for(Model::Foo.new)
          end
          assert "it delegates to the model" do
            equal :hello, @styler.hello
          end
        end
      end
      suite "InstanceMethods" do
        suite "#to_s" do
          setup :style, "a style" do
            @model = Model::Foo.new
            @style = ::Styler.new_style_for(@model)
            @result = [["style/foo/default"], {:@model => @model, :@type => :default}]
          end
          setup :style, "a complex style" do
            @model = Model::Foo.new
            @style = ::Styler.new_style_for(@model)
            @style.with(:bla => "foo")
            @result = [["style/foo/default"], {:@model => @model, :@type => :default, :@bla => "foo"}]
          end
          assert "it renders correctly" do
            equal(@result, @style.to_s)
          end
        end
      end
    end
  end
end
