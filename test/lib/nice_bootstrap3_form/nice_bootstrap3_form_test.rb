require_relative '../../test_helper'
class NiceBootstrap3FormTest < ActionView::TestCase
  test 'sanity test' do
    nice_bootstrap3_form_for :article do |f|
      assert f.instance_of? NiceBootstrap3Form::FormBuilder
    end
  end

  test 'return proper basic form markup' do
    with_form_for @article do |f|
      f.text_field :title
    end
    assert_select 'form.form-horizontal', false
    assert_select 'div.form-group label.control-label.show', count: 1, text: 'Title'
    assert_select 'div.form-group input.form-control#article_title[type="text"]', count: 1
  end

  test 'return form with passed through parameters' do
    with_form_for @article, html: { class: 'test-form' } {}
    assert_select 'form.form-horizontal', false
    assert_select 'form.test-form', count: 1
  end

  test 'return input with size parameter passed through' do
    with_form_for @article do |f|
      f.text_field :title, size: 22
    end
    assert_select 'form.form-horizontal', false
    assert_select 'div.form-group input.form-control#article_title[size=22]', count: 1
  end

  test 'return input with label parameter' do
    with_form_for @article do |f|
      f.text_field :title, label: 'Test Label'
    end
    assert_select 'form.form-horizontal', false
    assert_select 'div.form-group label.control-label.show', count: 1, text: 'Test Label'
  end

  test 'return input with different size' do
    with_form_for @article, size: :lg do |f|
      f.text_field :title, label: 'Test Label'
    end
    assert_select 'form.form-horizontal', false
    assert_select 'div.form-group input.form-control.input-lg', count: 1
  end

  test 'return input no label parameter' do
    with_form_for @article do |f|
      f.text_field :title, label: false
    end
    assert_select 'div.form-group label.control-label', false
  end

  test 'return input with help text parameter' do
    with_form_for @article do |f|
      f.text_field :title, help_text: 'Helpy help.'
    end
    assert_select 'form.form-horizontal', false
    assert_select 'div.form-group input.form-control[help_text]', false
    assert_select 'div.form-group p.help-block', count: 1, text: 'Helpy help.'
  end

  test 'return input with help text block' do
    with_form_for @article do |f|
      f.text_field :title do
        concat content_tag(:span, 'Appended within form-group.', class: 'special-block')
      end
    end
    assert_select 'form.form-horizontal', false
    assert_select 'div.form-group input.form-control[help_text]', false
    assert_select 'div.form-group span.special-block', count: 1, text: 'Appended within form-group.'
  end

  test 'return form with width set for label and input in horizontal form' do
    with_form_for @article, input_width: 9, horizontal: true do |f|
      f.text_field :title, help_text: 'This should be offset'
    end
    assert_select 'form.form-horizontal', count: 1
    assert_select 'div.form-group label.control-label.col-lg-3', count: 1
    assert_select 'div.form-group div.col-lg-9 input.form-control', count: 1
    assert_select 'div.form-group div.col-lg-9 p.help-block', count: 1, text: 'This should be offset'
  end

  test 'return input group with text field and addon' do
    with_form_for @article do |f|
      f.input_group 'Test' do
        concat f.text_field :title
        concat f.addon '.00'
      end
    end
    assert_select 'div.form-group div.input-group input.form-control', count: 1
    assert_select 'div.form-group div.input-group span.input-group-addon', count: 1, text: '.00'
  end

  test 'return input group with text field and clear button' do
    with_form_for @article do |f|
      f.input_group clear_button: true do
        concat f.text_field :title
      end
    end
    assert_select 'div.form-group div.input-group input.form-control', count: 1
    assert_select 'div.form-group div.input-group div.input-group-btn button.btn.btn-warning.btn-clear', count: 1
  end

  # test errors on form with has-error
end

# mock article w/ paragraphs
# mock article w/ paragraphs errors

### INPUTS
# text_field -- params +
# text_field -- help_test param +
# text_field -- help_test block +
# test_field -- input_width +
# test_field -- horizontal form +

### TOGGLES
# radio_btns +
# check_boxes
# radio_btns -- size +
# radio_btns -- global state (individual overrides global) ?
# radio_btns -- individual state  +
# radio_btns -- help_text +
# radio_btns -- horizontal form

### input group
# text_field -- label add on +
# text_field -- clear btn +

### btn_group

### helpers
# collapsable ?
# list_group do list_group_item
