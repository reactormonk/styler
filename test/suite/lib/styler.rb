BareTest.suite "Styler" do
  suite "Styler" do
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
        @result = Model::Baz
      end
      setup :model, "a model collection" do
        @model = [Model::Foo.new, Model::Bar::Foo.new, Model::Foo.new, Model::Baz.new]
        @result = [Style::Foo, Style::Bar, Style::Foo, Model::Baz]
      end
      assert "#new_style_for finds the right Styler object for :model" do
        if @model.respond_to? :each
          @model.each_with_index.all?{ |model,id|
            Styler.new_style_for(model, {}).is_a? @result[id]
          }
        else
          Styler.new_style_for(@model, {}).is_a? @result
        end
      end
    end
  end
end
