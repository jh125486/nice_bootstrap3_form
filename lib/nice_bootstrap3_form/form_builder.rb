#
  # def association(label, *args)
    # label = label.to_s
    # key   = label.foreign_key.to_sym
    # klass = label.classify.constantize
    # options = args.extract_options!
    # options_attribute = options[:attribute] || :option_label
#
    # select(key, klass.all.map {|obj| [obj.send(options_attribute), obj.id] }, *(args << options))
  # end
# require_relative 'helpers'
require 'nested_form/builder_mixin'
class NiceBootstrap3Form::FormBuilder < ActionView::Helpers::FormBuilder
  include NestedForm::BuilderMixin
  include ::NiceBootstrap3Form::Helpers
  include ::NiceBootstrap3Form::Classes
  include ::NiceBootstrap3Form::Wrappers
  include ::NiceBootstrap3Form::Components

  attr_reader :template, :object, :object_name
  attr_accessor :horizontal, :input_width, :media, :size
  delegate :content_tag, :link_to, :concat, :capture, :pluralize, :btn_icon_and_text, :icon_and_text, to: :template

  DEFAULTS = {
    media: 'lg', # media/page column sizing
    size:  nil,  # field size
    horizontal: false
  }

  def initialize(*args)
    options = args.extract_options!
    DEFAULTS.merge(options).each do |key, value|
      instance_variable_set(:"@#{key}", value)
    end
    set_label_and_input_width(options[:label_width], options[:input_width])
    options[:html] ||= {}
    options[:html][:class] ||= ''
    options[:html][:class] << ' form-horizontal' if horizontal
    super(*args << options[:html])
  end

  def input_group(*args, &block)
    options, label, klasses = _form_group_setup(args)
    offset = !label && horizontal
    size, help_block, label_classes, help_block_classes = _input_group_setup(options)
    content_tag(:div, class: klasses) do
      concat content_tag(:label, label.humanize, class: label_classes) if label
      concat _input_group_content(options, _input_group_classes(size, offset), &block)
      concat content_tag(:div,   help_block, class: help_block_classes) unless help_block.empty?
    end
  end

  def btn_group(*args, &block)
    options, label, klasses = _form_group_setup(args)
    @inside_group = true
    @btn_state = options[:state]
    content = content_tag(:div, class: _btn_group_classes(options[:size] || @size), data: { toggle: 'buttons' }, &block)
    content += clear_button(:radio) if options[:clear_button]
    @inside_group = false
    @btn_state = nil
    content_tag(:div, class: klasses) do
      concat content_tag(:label, label.humanize, class: _control_label_classes) if label
      concat content_tag(:div, content, class: _btn_toolbar_classes(!label && horizontal))
      concat help_block_for_group(options)
    end
  end

  protected

  def errors_on?(attribute)
    object.errors[attribute].present? if attribute && object.respond_to?(:errors)
  end

  def errors_for(attribute)
    object.errors[attribute].to_sentence.humanize if attribute
  end

  def required?(attribute)
    object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  private

  def help_block_for_group(options)
    content = ''.html_safe
    content << help_block(options[:help_text], class: options[:help_text_class]) if options[:help_text]
    content << help_block('ERROR: ' + errors_for(options[:has_error_on])) if errors_on?(options[:has_error_on])
    content.blank? ? '' : content_tag(:div, content, class: (_input_offset_classes if horizontal))
  end

  def _form_group_setup(args)
    options = args.extract_options!
    label = args.shift
    [options, label, _form_group_classes(options[:has_error_on], options[:class])]
  end

  def _input_group_setup(options)
    size = options[:size] || @size
    help_block = help_block_for_group(options)
    label_classes = _control_label_classes(options[:has_error_on])
    help_block_classes = _input_offset_classes if horizontal
    [size, help_block, label_classes, help_block_classes]
  end

  def _input_group_content(options, klasses, &block)
    @inside_group = true
    content = capture(&block)
    content += clear_button(:text_field) if options[:clear_button]
    @inside_group = false
    content_tag(:div, content, class: klasses)
  end

  def set_label_and_input_width(label_width, input_width)
    if label_width
      @label_width = label_width
      @input_width = input_width || 12 - label_width
    elsif input_width
      @input_width = input_width
      @label_width = label_width || 12 - input_width
    end
    @input_width_class = "col-#{@media}-#{@input_width}"
    @label_width_class = "col-#{@media}-#{@label_width}"
  end
end
