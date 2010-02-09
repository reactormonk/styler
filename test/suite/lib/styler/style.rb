BareTest.suite do
  suite "Styler" do
    suite "Style" do
      suite "ClassMethods" do
        suite "#association" do
          setup :assoc, "a single association" do
            @styler = Styler.new_styler_for(Model::Foo.new).foo
            @result_class = Style::Bar
          end
          setup :assoc, "an association collection" do
            @styler = Styler.new_styler_for(Model::Foo.new).fooz
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
            @styler = Styler.new_styler_for(Model::Foo.new)
          end
          assert "it delegates to the model" do
            equal :hello, @styler.hello
          end
        end
      end
      suite "InstanceMethods" do
      end
    end
  end
end
