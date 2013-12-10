module NiceBootstrap3Form::Wrappers
  def _offset_wrapper(&block)
    if horizontal
      content_tag(:div, class: _input_offset_classes, &block)
    else
      block.call
    end
  end

  def _input_group_wrapper(attribute, &block)
    if @inside_group
      block.call
    else
      content_tag(:div, class: _form_group_classes(attribute), &block)
    end
  end

  def _input_wrapper(attribute, &block)
    if horizontal && !@inside_group
      content_tag(:div, class: @input_width_class, &block)
    else
      capture(&block)
    end
  end
end
