require File.join(File.dirname(__FILE__), '..', 'bin', 'stack')

require 'test/unit'

class StackTest < Test::Unit::TestCase

  def setup
		@stack = Stack.new
		@stack << 1
  end

	def test_push

		@stack.push(2)
		assert_equal(@stack, [1,2])		
	end

	def test_pop
		item = @stack.pop
		assert_equal(item, 1)
	end

	def teardown
		@stack.clear
	end
end
