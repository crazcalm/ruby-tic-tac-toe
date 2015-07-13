require File.join(File.dirname(__FILE__), '..', 'bin', 'players')

require 'test/unit'

class PlayerTest < Test::Unit::TestCase

  def setup
		@limit = 3
		@name = "Marcus"
		@marker = "X"
		@player = Player.new(@marker, @limit, @name)
  end

	def test_move
		assert_equal(@marker, @player.move)
	end

	def test_try_limit
		assert_equal(@limit, @player.try_limit)
	end

	def test_name
		assert_equal(@name, @player.name)
	end

	def test_invalid_move
		@player.invalid_move
		assert_equal(@limit - 1, @player.try_limit)
	end
end


class PlayerFactoryTest < Test::Unit::TestCase
	
	def setup
	end

	def teardown
	end
end
