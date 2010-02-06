BareTest.suite do
  suite "Stylist" do
    suite "Style" do
      suite "ClassMethods" do
        suite "#association" do
          setup :assoc, "a single association" do
            @stylist = Stylist.new_stylist_for(Model::Foo.new).foo
            @result_class = Style::Bar
          end
          setup :assoc, "an association collection" do
            @stylist = Stylist.new_stylist_for(Model::Foo.new).fooz
            @result_class = Style::Bar
          end
          assert "it maps models to stylists in :assoc" do
            if @stylist.respond_to? :each
              @stylist.all? {|style| equal(style.__class__,@result_class)}
            else
              equal(@stylist.__class__, @result_class)
            end
          end
        end
        suite "#delegate" do
          setup do
            @stylist = Stylist.new_stylist_for(Model::Foo.new)
          end
          assert "it delegates to the model" do
            equal :hello, @stylist.hello
          end
        end
      end
      suite "InstanceMethods" do
      end
    end
  end
end
