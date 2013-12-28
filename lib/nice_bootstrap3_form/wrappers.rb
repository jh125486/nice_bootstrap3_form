# encoding: utf-8
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

  def _input_wrapper(attribute, options, &block)
    if horizontal && !@inside_group
      klasses = options[:label].false? ? _input_offset_classes : @input_width_class
      content_tag(:div, class: klasses, &block)
    else
      capture(&block)
    end
  end
end
