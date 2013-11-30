# require 'nice_bootstrap3_form'
module NiceBootstrap3Form::Classes
  def _form_group_classes(attribute, *classes)
    classes.tap do |klasses|
      klasses << 'form-group'
    end.uniq.compact << ('has-error' if errors_on?(attribute))
  end

  def _btn_toolbar_classes(offset, *classes)
    classes.tap do |klasses|
      klasses << 'btn-toolbar'
      klasses << group_sizing_classes(offset)
    end.uniq.compact
  end

  def _btn_group_classes(size, *classes)
    classes.tap do |klasses|
      klasses << 'btn-group'
      klasses << "btn-group-#{size}" if size
    end.uniq.compact
  end

  def _control_label_classes(attribute = nil, *classes)
    classes.tap do |klasses|
      klasses << 'control-label'
      if @inside_group
        klasses << 'input-group-addon'
      elsif horizontal
        klasses << @label_width_class
      else
        klasses << 'show'
      end
    end.uniq.compact << ('has-error' if errors_on?(attribute))
  end

  def _form_control_classes(attribute, *classes)
    classes.tap do |klasses|
      klasses << 'form-control'
      klasses << "input-#{@size}" if @size
      klasses << 'pull-left show' if @inside_group
    end.uniq.compact << ('has-error' if errors_on?(attribute))
  end

  def _input_group_classes(size, offset, *classes)
    classes.tap do |klasses|
      klasses << 'input-group'
      klasses << "input-group-#{size}" if size
      klasses << group_sizing_classes(offset)
    end.uniq.compact
  end

  private

  def group_sizing_classes(offset)
    if offset
      _input_offset
    elsif horizontal
      @input_width_class
    end
  end
end
