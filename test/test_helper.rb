require 'minitest/autorun'
require File.expand_path('../../lib/nice_bootstrap3_form.rb', __FILE__)
require_relative 'support/dummy_class.rb'

def helper
  @helper ||= DummyClass.new
end

