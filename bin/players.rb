# Need to create a factory for Players
def players_factory(player1, player2, player1_marker_x=true)
  players = []

	# Cases of initializing the players
	if player1_marker

		# Case 1
		if player1 == "human"
			players << Player.new("X")
		else
			players << PlayerBot.new("X")
		end

		if player2 == "human"
			players << Player.new("O")
		else
			players << PlayerBot.new("O")
		end

	else
		# Case2
		if player1 == "human"
			players << Player.new("O")
		else
			players << PlayerBot.new("O")
		end

		if player2 == "human"
			players << Player.new("X")
		else
			players << PlayerBot.new("X")
		end
	end

	players
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
