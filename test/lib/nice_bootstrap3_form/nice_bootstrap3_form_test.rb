require_relative '../../test_helper'

describe NiceBootstrap3Form do
  describe 'btn button' do
    it 'returns BS3 btn with parameters' do
      button = helper.btn('I am a Button', type: 'submit', state: 'primary', class: 'pull-left')
      button.must_match(/^<button/)
      button.must_match(/type="submit"/)
      button.must_match(/name="button"/)
      button.must_match(/class="pull-left btn btn-primary"/)
      button.must_match(/>I am a Button<\/button>$/)
    end
  end

  describe 'btn link_to' do
    it 'returns BS3 btn link_to with parameters' do
      button = helper.btn('Link to Google.com', 'http://google.com', state: 'danger', size: 'xs')
      button.must_match(/^<a/)
      button.must_match(/href="http:\/\/google.com"/)
      button.must_match(/class="btn btn-danger btn-xs"/)
      button.must_match(/>Link to Google.com<\/a>$/)
    end
  end


end


# mock document setup

### INPUTS
# text_field -- params
# text_field -- help_test param
# text_field -- help_test block
# test_field -- input_width
# test_field -- horizontal form

### TOGGLES
# radio_btns
# check_boxes
# radio_btns -- size
# radio_btns -- global state (individual overrides global)
# radio_btns -- individual state
# radio_btns -- help_test
# radio_btns -- horizontal form

# form Errors

### input group
# text_field -- label add on
# text_field -- clear btn

### btn_group

### helpers
# link to btn
# button btn
# btn classes helper
# panel
# panel -- header
# panel -- footer
# panel -- state
