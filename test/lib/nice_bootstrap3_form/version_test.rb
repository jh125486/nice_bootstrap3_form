require_relative '../../test_helper'

class TestNiceBootstrap3Form < MiniTest::Unit::TestCase
  def test_version_must_be_defined
    refute_nil NiceBootstrap3Form::VERSION
  end
end
