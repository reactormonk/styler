BareTest.suite "Stylist" do
  suite "Stylist" do
    suite "Style finding" do
      setup :model, "a model without namespace" do
        @model = Foo.new
        @result = Stylist::Foo
      end
      setup :model, "a model with namespace" do
        @model = Bar::Foo.new
        @result = Stylist::Bar::Foo
      end
      setup :model, "a model without style" do
        @model = Bar::Baz.new
        @result = nil
      end
      assert "#style_for finds the right Stylist object for :model" do
        equal @result, ::Stylist.send(:style_for, @model)
      end
      assert "#new_stylist_for creates a new Style instance for :model" do
        @result = NilClass unless @result
        equal(@result, ::Stylist.new_stylist_for(@model).class)
      end
    end
  end
end
