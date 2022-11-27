class TailwindFormBuilder < ActionView::Helpers::FormBuilder

    def text_field_tag(attribute, options={})
        super(attribute,options.reverse_merge(class: "bg-rose-500"))
    end

end