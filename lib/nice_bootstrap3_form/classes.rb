module NiceBootstrap3Form::Classes
  def _form_group_classes(attribute, *classes)
    classes.tap do |klasses|
      klasses << 'form-group' << ('has-error' if errors_on?(attribute))
    end.compact_squish_join
  end

  def _btn_toolbar_classes(offset, *classes)
    classes.tap do |klasses|
      klasses << 'btn-toolbar'
      klasses << group_sizing_classes(offset)
    end.compact_squish_join
  end

  def _btn_group_classes(size, *classes)
    classes.tap do |klasses|
      klasses << 'btn-group'
      klasses << "btn-group-#{size}" if size
    end.compact_squish_join
  end

  def _control_label_classes(attribute = nil, *classes)
    classes.tap do |klasses|
      klasses << 'control-label' << ('has-error' if errors_on?(attribute))
      if @inside_group
        klasses << 'input-group-addon'
      elsif horizontal
        klasses << @label_width_class
      else
        klasses << 'show'
      end
    end.compact_squish_join
  end

  def _form_control_classes(attribute, *classes)
    classes.tap do |klasses|
      klasses << 'form-control'
      klasses << "input-#{@size}" if @size
      klasses << 'pull-left show' if @inside_group
    end.compact_squish_join
  end

  def _input_group_classes(size, offset, *classes)
    classes.tap do |klasses|
      klasses << 'input-group'
      klasses << "input-group-#{size}" if size
      klasses << group_sizing_classes(offset)
    end.compact_squish_join
  end

  def _input_offset_classes
    ["col-#{@media}-offset-#{@label_width}", "#{@input_width_class}"]
  end

  def _input_addon_classes(*classes)
    classes.tap do |klasses|
      klasses << 'input-group-addon'
    end.compact_squish_join
  end

  private

  def group_sizing_classes(offset)
    if offset
      _input_offset_classes
    elsif horizontal
      @input_width_class
    end
  end
end
