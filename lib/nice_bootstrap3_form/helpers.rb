require 'active_support'
module NiceBootstrap3Form::Helpers
  include ActionView::Helpers::FormTagHelper

  def nice_bootstrap3_form_for(record, *args, &block)
    options = args.extract_options!
    options[:html] = { role: 'form' } if options[:html].nil?
    options[:builder] = NiceBootstrap3Form::FormBuilder
    _override_field_error_proc do
      send :form_for, record, *(args << options), &block
    end
  end

  def panel(*args, &block)
    options = args.extract_options!
    heading_size = options[:heading_size] || 'h2'
    content_tag :div, id: options[:id], class: options[:class] do
      concat content_tag(heading_size, options[:title], class: 'panel-title panel-heading') if options[:title]
      concat content_tag(:div, options[:body], class: 'panel-body')
      concat content_tag(:div, options[:footer], class: 'panel-footer') if options[:footer]
    end
  end

  def btn(*args, &block)  # creates either a button, or a link_to button if a url is given
    options = args.extract_options!
    btn_text = args.shift
    to = args.shift
    options[:class] = btn_classes(options[:state], options[:size], options[:class])
    to ? link_to(btn_text, to, options, &block) : button_tag(btn_text, *(args << options), &block)
  end

  def btn_classes(state, size = nil, *classes)
    state ||= 'default'
    size ||= nil
    classes.tap do |klasses|
      klasses << 'btn'
      klasses << "btn-#{state}"
      klasses << "btn-#{size}" if size
    end.uniq.compact
  end

  def radio_btn_tag(object_name, method, value, options = {})
    label = options[:label] || value.humanize
    klasses = btn_classes(options[:state], options[:size], options[:class])
    content_tag(:label, class: klasses) do
      concat template.radio_button(object_name, method, value, options)
      concat label
    end
  end

  def check_box_btn_tag(object_name, method, options = {}, checked_value = '1', unchecked_value = '0')
    label = options[:label] || method.humanize
    klasses = btn_classes(options[:state], options[:size], options[:class])
    content_tag(:label, class: klasses) do
      concat template.check_box(object_name, method, options, checked_value, unchecked_value)
      concat label
    end
  end

  def clear_button(input_type)
    if input_type == :radio
      content_tag(:div, class: 'btn-group') do
        template.button_tag '&times;'.html_safe, type: 'button', class: 'btn-clear clear', role: 'button'
      end
    elsif input_type == :text_field
      content_tag(:div, class: 'input-group-btn') do
        template.button_tag 'X', type: 'button', class: 'btn btn-warning btn-clear', role: 'button'
      end
    end
  end

  private

  BLANK_FIELD_ERROR_PROC = ->(input, _){ input }

  def _override_field_error_proc
    original_field_error_proc = ::ActionView::Base.field_error_proc
    ::ActionView::Base.field_error_proc = BLANK_FIELD_ERROR_PROC
    yield
  ensure
    ::ActionView::Base.field_error_proc = original_field_error_proc
  end
end
