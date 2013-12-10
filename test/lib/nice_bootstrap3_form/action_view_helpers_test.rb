require_relative '../../test_helper'

class ActionViewHelpersTest < MiniTest::Unit::TestCase
  def test_btn_to_bs3_button
    expected = '<button type="submit" name="button" class="pull-left btn btn-primary">I am a Button</button>'
    button = helper.btn('I am a Button', type: 'submit', state: 'primary', class: 'pull-left')
    assert_dom_equal expected, button
  end

  def test_link_to_bs3_btn_with_parameters
    expected = '<a href="http://google.com" class="btn btn-danger btn-xs">Link to Google.com</a>'
    button = helper.btn('Link to Google.com', 'http://google.com', state: 'danger', size: 'xs')
    assert_dom_equal expected, button
  end

  def test_btn_classes_helper_with_defaults
    klasses = helper.btn_classes
    assert_includes klasses, 'btn'
    assert_includes klasses, 'btn-default'
  end

  def test_btn_with_only_state_string_or_symbol_specified
    klasses = helper.btn_classes('primary')
    assert_includes klasses, 'btn'
    assert_includes klasses, 'btn-primary'
    klasses = helper.btn_classes(:primary)
    assert_includes klasses, 'btn'
    assert_includes klasses, 'btn-primary'
  end

  def test_default_btn_class_with_only_size_specified
    klasses = helper.btn_classes(size: 'xs')
    assert_includes klasses, 'btn'
    assert_includes klasses, 'btn-default'
    assert_includes klasses, 'btn-xs'
  end

  def test_btn_class_with_state_and_size
    klasses = helper.btn_classes('warning', size: :sm)
    assert_includes klasses, 'btn'
    assert_includes klasses, 'btn-warning'
    assert_includes klasses, 'btn-sm'
  end

  def test_default_empty_panel
    expected = '<div class="panel panel-default"><div class="panel-body"></div></div>'
    panel = helper.panel
    assert_dom_equal expected, panel
  end

  def test_default_panel_with_content_from_block
    expected = '<div class="panel panel-default"><div class="panel-body">this is some panel body text</div></div>'
    panel = helper.panel { 'this is some panel body text' }
    assert_dom_equal expected, panel
  end

  def test_default_panel_with_content_from_parameters
    expected = '<div class="panel panel-default"><div class="panel-body">this is some panel body text</div></div>'
    panel = helper.panel(body: 'this is some panel body text')
    assert_dom_equal expected, panel
  end

  def test_primary_panel_with_a_heading_and_footer
    expected  = '<div class="panel panel-primary">'
    expected << '<h2 class="panel-title panel-heading">Test Title</h2>'
    expected << '<div class="panel-body">Test Panel Content</div>'
    expected << '<div class="panel-footer">Footer is blargh</div></div>'
    panel = helper.panel(title: 'Test Title', footer: 'Footer is blargh', state: :primary) { 'Test Panel Content' }
    assert_dom_equal expected, panel
  end
end
