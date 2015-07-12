require File.join(File.dirname(__FILE__), '..', 'bin', 'players')

require 'test/unit'

class PlayerTest < Test::Unit::TestCase

  def setup
  end

  def test_correct
    assert_equal(1,1, "YES")
  end

  def test_wrong
    assert_equal(1,2, "IIIIIII")
  end

  def teardown
  end
end
