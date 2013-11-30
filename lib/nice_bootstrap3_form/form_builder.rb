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
  attr_accessor :horizontal, :input_width
  delegate :content_tag, :link_to, :concat, :capture, :pluralize, :btn_icon_and_text, :icon_and_text, to: :template

  def initialize(*args)
    options = args.extract_options!
    set_defaults(options)
    options[:html] ||= {}
    options[:html][:class] ||= ''
    options[:html][:class] << ' form-horizontal' if horizontal

    super(*args << options[:html])
  end

  def input_group(*args, &block)
    options, label, klasses = _form_group_setup(args)
    @inside_group = true
    content = capture(&block)
    content += clear_button(:text_field) if options[:clear_button]
    @inside_group = false
    content_tag(:div, class: klasses) do
      concat content_tag(:label, label.humanize, class: _control_label_classes(options[:has_error_on])) if label
      concat content_tag(:div, content, class: _input_group_classes(options[:size] || @size, !label && horizontal))
      concat content_tag(:div, help_group_block(options), class: (_input_offset if horizontal))
    end
  end

  def btn_group(*args, &block)
    options, label, klasses = _form_group_setup(args)
    @inside_group = true
    content = content_tag(:div, class: _btn_group_classes(options[:size] || @size), data: { toggle: 'buttons' }, &block)
    content += clear_button(:radio) if options[:clear_button]
    @inside_group = false
    content_tag(:div, class: klasses) do
      concat content_tag(:label, label.humanize, class: _control_label_classes) if label
      concat content_tag(:div, content, class: _btn_toolbar_classes(!label && horizontal))
      concat content_tag(:div, help_group_block(options), class: (_input_offset if horizontal))
    end
  end

  protected

  def _input_offset
    "col-#{@media}-offset-#{@label_width} #{@input_width_class}"
  end

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

  def help_group_block(options)
    help = ''.html_safe
    help << content_tag(:div, options[:help_text], class: options[:help_text_class]) if options[:help_text]
    help << help_block('ERROR: ' + errors_for(options[:has_error_on])) if errors_on?(options[:has_error_on])
    help
  end

  def _form_group_setup(args)
    options = args.extract_options!
    label = args.shift
    [options, label, _form_group_classes(options[:has_error_on]) << options[:class]]
  end

  def set_defaults(options)
    @input_width = options[:input_width] || 12
    @label_width = options[:label_width] || (12 - @input_width)
    @media = options[:media] || 'lg' # media/page column sizing
    @size  = options[:size]  || nil   # field size
    self.horizontal = options[:horizontal] || false
    @input_width_class = "col-#{@media}-#{@input_width}"
    @label_width_class = "col-#{@media}-#{@label_width}"
    @inside_group = false
  end
end

# XXX  move this to another module NiceBootstrap3FormFor::FormHelpers   'nice_bootstrap3_form_for/form_helpers.rb'
# remove wrapping 'field_with_errors' div
# ActionView::Base.field_error_proc = proc { |html_tag, instance|
  # "#{html_tag}".html_safe
# }
