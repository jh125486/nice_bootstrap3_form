# encoding: utf-8
require 'active_support'
module NiceBootstrap3Form::Helpers
  include ActionView::Helpers::FormTagHelper

  def nice_bootstrap3_form_for(record, options = {}, &block)
    options[:builder] = NiceBootstrap3Form::FormBuilder
    options[:html] ||= {}
    options[:html].merge(role: 'form')
    _override_field_error_proc do
      form_for(record, options, &block)
    end
  end

  def panel(*args, &block)
    options = args.extract_options!
    title = args.shift || options[:title]
    heading_size = options[:heading_size] || 'h2'
    body = block_given? ? capture(&block) : options[:body]
    content_tag :div, id: options[:id], class: panel_classes(options[:state], class: options[:class]) do
      concat content_tag(heading_size, title, class: 'panel-title panel-heading') if title
      concat content_tag(:div, body, class: 'panel-body')
      concat content_tag(:div, options[:footer], class: 'panel-footer') if options[:footer]
    end
  end

  def panel_classes(*args)
    options = args.extract_options!
    state = args.shift || options[:state] || 'default'
    classes = [*options[:class]] || []
    classes.tap do |klasses|
      klasses << 'panel'
      klasses << "panel-#{state}"
    end.compact_squish_join
  end

  def btn(*args, &block)  # creates either a button, or a link_to button if a url is given
    options = args.extract_options!
    btn_text = args.shift || options[:label]
    to_path = args.shift
    klasses = btn_classes(options[:state], size: options[:size], class: options[:class])
    html_options = options.except(:state, :size, :class, :label).merge(class: klasses)
    to_path ? link_to(btn_text, to_path, html_options, &block) : button_tag(btn_text, html_options, &block)
  end

  def btn_classes(*args)
    options = args.extract_options!
    state = args.shift || options[:state] || 'default'
    classes = [*options[:class]] || []
    classes.tap do |klasses|
      klasses << 'btn'
      klasses << "btn-#{state}"
      klasses << "btn-#{options[:size]}" if options[:size]
    end.compact_squish_join
  end

  def btn_icon_and_text(icon, text)
    content_tag(:span, text, class: "ui-icon ui-icon-#{icon} text-hide") +
    content_tag(:span, text, class: 'btn-text')
  end

  def icon_and_text(icon, text)
    content_tag(:span, nil, class: "ui-icon ui-icon-#{icon} text-hide") +
    text
  end

  def radio_btn_tag(object_name, method, tag_value, options = {})
    label = options[:label] || tag_value.humanize
    klasses = btn_classes(@btn_state || options[:state], size: options[:size], class: options[:class])
    html_options = options.except(:state, :size, :class, :label)
    content_tag(:label, class: klasses) do # XXX should this be a general helper or a form_helper
      concat template.radio_button(object_name, method, tag_value, html_options)
      concat label
    end
  end

  def check_box_btn_tag(object_name, method, options = {}, checked_value = '1', unchecked_value = '0')
    label = options[:label] || method.humanize
    klasses = btn_classes(@btn_state || options[:state], size: options[:size], class: options[:class])
    html_options = options.except(:state, :size, :class, :label)
    content_tag(:label, class: klasses) do # XXX should this be a general helper or a form_helper
      concat template.check_box(object_name, method, html_options, checked_value, unchecked_value)
      concat label
    end
  end

  def clear_button(input_type) # XXX should this be a general helper or a form_helper
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

  BLANK_FIELD_ERROR_PROC = ->(input, _) { input }

  def _override_field_error_proc
    original_field_error_proc = ::ActionView::Base.field_error_proc
    ::ActionView::Base.field_error_proc = BLANK_FIELD_ERROR_PROC
    yield
  ensure
    ::ActionView::Base.field_error_proc = original_field_error_proc
  end
end

ActionView::Base.send :include, NiceBootstrap3Form::Helpers
