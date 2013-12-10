require 'rails'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'active_model'
require 'action_controller'
require 'action_view'
require 'action_view/template'

require 'rails/test_help'
require 'minitest/rails'
require 'action_view/test_case'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nice_bootstrap3_form'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end

def helper
  @helper ||= DummyHelperClass.new
end

def template
  @template = Object.new
  @template.extend NiceBootstrap3Form::Helpers
  @template.extend ActionView::Helpers::FormHelper
  @template.extend ActionView::Helpers::FormOptionsHelper
  @template.extend ActionView::Helpers::TagHelper
  @template.extend ActionView::Helpers::UrlHelper
  @template.extend ActionView::Context
end

module MiniTest::Assertions
  def assert_dom_equal(expected, actual, message = nil)
    expected_dom = HTML::Document.new(expected).root
    actual_dom   = HTML::Document.new(actual).root
    assert_equal expected_dom, actual_dom, message
  end
end

class ActionView::TestCase
  include NiceBootstrap3Form::Helpers

  setup :set_controller
  setup :setup_article

  def set_controller
    @controller = MockController.new
  end

  def setup_article
    @article = Article.new
  end

  def protect_against_forgery?
    false
  end

  def article_path(*args)
    '/articles'
  end
  alias_method :articles_path, :article_path

  protected

  def with_form_for(*args, &block)
    concat nice_bootstrap3_form_for(*args, &(block || proc {}))
  end
end
