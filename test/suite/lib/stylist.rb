BareTest.suite "Stylist" do
  suite "Stylist" do
    suite "Style finding" do
      setup :model, "a model without namespace" do
        @model = Model::Foo.new
        @result = Style::Foo
      end
      setup :model, "a model with namespace" do
        @model = Model::Bar::Foo.new
        @result = Style::Bar
      end
      setup :model, "a model without style" do
        @model = Model::Baz.new
        @result = nil
      end
      assert "#style_for finds the right Stylist object for :model" do
        equal @result, Stylist.send(:style_for, @model)
      end
      assert "#new_stylist_for creates a new Style instance for :model" do
        @result = NilClass unless @result
        Stylist.new_stylist_for(@model).is_a? @result
      end
    end
  end
end
