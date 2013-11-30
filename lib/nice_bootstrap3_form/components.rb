require 'action_view'
module NiceBootstrap3Form::Components
  INPUTS = ActionView::Helpers::FormBuilder.instance_methods.grep(/_(area|field|select)$/mx).map(&:to_sym) << :select
  INPUTS.delete(:hidden_field)
  TOGGLES = %w(check_box radio_button).map(&:to_sym)
  INPUT_PARAMS = [:help_text, :help_text_class, :label]

  INPUTS.each do |input|
    define_method input do |attribute, *args, &block|
      options = args.extract_options!
      input_options = options.except!(INPUT_PARAMS).merge(class: _form_control_classes(attribute, options[:class]))
      _input_group_wrapper(attribute) do
        input_label(attribute, options) +
        _input_wrapper(attribute) do
          concat super(attribute, *(args << input_options))
          concat help_block(options[:help_text], class: options[:help_text_class]) if options[:help_text]
          concat help_block('ERROR: ' + errors_for(attribute)) if errors_on?(attribute) && !@inside_group
          block.call if block.present?
        end
      end
    end
  end

  TOGGLES.each do |toggle|   # CHECKBOXES, RADIOS
    define_method toggle do |attribute, *args, &block|
      options = args.extract_options!
      label = options[:label] || attribute.humanize
      klass = toggle.eql?(:check_box) ? 'checkbox' : 'radio'
      _input_group_wrapper(attribute) do
        _offset_wrapper do
          content_tag(:div, class: klass) do
            template.label(object_name, attribute, label) do
              concat super(attribute, *args)
              concat label
            end
          end
        end
      end
    end
  end

  def fields_for(record_name, record_object = nil, options = {}, &block)
    options.merge!(builder: NiceBootstrap3Form::FormBuilder, horizontal: horizontal, input_width: @input_width)
    super(record_name, record_object, options, &block)
  end

  def form_actions(*args, &block)
    options = args.extract_options!
    klasses = %w(form-group actions text-center) << options[:class]
    submit_btn_text = (object.new_record? ? 'Create' : 'Update') + ' ' + object_name.humanize

    content_tag(:div, class: klasses) do
      _offset_wrapper do
        concat btn(submit_btn_text, type: 'submit', state: 'primary', class: 'pull-left')
        concat btn('Cancel', :back, state: 'warning', class: 'pull-right')
        block.call if block_given?
      end
    end
  end

  def help_block(*args, &block)
    options = args.extract_options!
    klasses = %w(help-block)
    klasses << options[:class]
    klasses << _input_offset if @inside_group
    text = args.shift
    text += capture(&block) if block_given?
    content_tag(:p, text, class: klasses.uniq.compact)
  end

  def form_errors_panel(*args, &block)
    if object.errors.any?
      options = args.extract_options!
      panel_state = options[:state] || 'danger'
      klasses = %w(panel) << "panel-#{panel_state}" << options[:class]
      title = args.shift || "#{pluralize object.errors.count, 'error'} prohibited this #{object_name} from being saved:"
      errors = object.errors.full_messages.map { |msg| content_tag :li, icon_and_text('alert', msg) }.reduce(:<<)
      panel_body = content_tag(:ul, errors, class: 'list-unstyled')
      panel_body += capture(&block) if block_given?
      panel id: 'error_explanation', class: klasses, title: title, body: panel_body, footer: options[:footer_text]
    end
  end

  def radio_btn(attribute, value = false, options = {})
    radio_btn_tag(object_name, attribute, value, options)
  end

  def check_box_btn(attribute, *args)
    options = args.extract_options!
    if @inside_group
      check_box_btn_tag(object_name, attribute, options)
    else
      btn_group do
        check_box_btn_tag(object_name, attribute, options)
      end
    end
  end

  private

  def input_label(attr, options)
    if (options[:label] && @inside_group) || !@inside_group
      label(attr, options[:label] || attr.humanize, class: _control_label_classes(attr, options[:class]))
    else
      ''.html_safe
    end
  end
end
