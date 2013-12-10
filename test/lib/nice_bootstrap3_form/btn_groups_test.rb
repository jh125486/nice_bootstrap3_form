require_relative '../../test_helper'
class BtnGroupsTest < ActionView::TestCase
  test 'returns group of radio choices with options' do
    with_form_for @article do |f|
      f.btn_group 'Classification', size: 'xs', help_text: 'Classification list', has_error_on: :classification_level do
        @article.class::VALID_CLASSIFICATION_LEVELS.each do |level|
          concat f.radio_btn :classification_level, level
        end
      end
    end
    assert_select 'div.form-group' do
      assert_select 'label.control-label.show', count: 1, text: 'Classification'
      assert_select 'div.btn-toolbar' do
        assert_select 'div.btn-group.btn-group-xs[data-toggle="buttons"]', count: 1
        @article.class::VALID_CLASSIFICATION_LEVELS.each do |level|
          assert_select "label.btn.btn-default > input[type='radio'][value='#{level}']", count: 1
        end
      end
      assert_select 'div > p.help-block', count: 1, text: 'Classification list'
    end
  end

  test 'returns group of radio choices with different labels/states' do
    with_form_for @article do |f|
      f.btn_group 'Classification', has_error_on: :classification_level do
        concat f.radio_btn :classification_level, 'Unclass', label: 'U', state: 'success'
        concat f.radio_btn :classification_level, 'Secret', label: 'S', state: 'danger'
        concat f.radio_btn :classification_level, 'Top Secret', label: 'TS', state: 'warning'
      end
    end
    assert_select 'div.form-group > div.btn-toolbar' do
      assert_select 'div.btn-group[data-toggle="buttons"]', count: 1
      assert_select 'label.btn.btn-success input[type="radio"][value="Unclass"]', count: 1
      assert_select 'label.btn.btn-success', count: 1, text: 'U'
      assert_select 'label.btn.btn-danger input[type="radio"][value="Secret"]', count: 1
      assert_select 'label.btn.btn-danger', count: 1, text: 'S'
      assert_select 'label.btn.btn-warning input[type="radio"][value="Top Secret"]', count: 1
      assert_select 'label.btn.btn-warning', count: 1, text: 'TS'
    end
  end

  test 'returns group of radio choices with global state set and horizontal label' do
    with_form_for @article, horizontal: true, input_width: 10 do |f|
      f.btn_group 'Classification', state: 'info', has_error_on: :classification_level do
        concat f.radio_btn :classification_level, 'Unclass'
        concat f.radio_btn :classification_level, 'Secret'
        concat f.radio_btn :classification_level, 'Top Secret'
      end
    end
    assert_select 'div.form-group' do
      assert_select 'label.control-label.col-lg-2', count: 1, text: 'Classification'
      assert_select 'div.btn-toolbar.col-lg-10', count: 1
      assert_select 'label.btn.btn-info', count: 3
    end
  end

  test 'returns group of radio choices with no label (horizontally offset)' do
    with_form_for @article, horizontal: true, input_width: 10 do |f|
      f.btn_group has_error_on: :classification_level do
        concat f.radio_btn :classification_level, 'Unclass'
        concat f.radio_btn :classification_level, 'Secret'
        concat f.radio_btn :classification_level, 'Top Secret'
      end
    end
    assert_select 'div.form-group > div.btn-toolbar.col-lg-offset-2.col-lg-10', count: 1
  end
end
