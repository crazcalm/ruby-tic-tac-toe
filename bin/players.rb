# Need to create a factory for Players
def define_players(player1, player2)
	
end

class Player
	attr_reader :marker

  def initialize(marker)
		@marker = marker
	end

	def move
		@marker
	end
end

class PlayerBot < Player
	def initialize(marker)
		super(marker)
	end

	# Need to add move Logic
	def move
	end
end
