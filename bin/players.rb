##Notes
# I think that if your opponent is a bot, then the
# board should make the move for the bot.
# This makes sense because the board knows the
# the state of the board, whereas the bot
# Knows nothing about the board.

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
	attr_accessor :try_limit, :name

  def initialize(marker, try_limit=3, name="Player1")
		@marker = marker
		@try_limit = try_limit
		@name = name
	end

	def move
		@marker
	end

	def invalid_move
		@try_limit -=1
	end
end

# Should remove class and add a bot boolean to the
# Player class.
class PlayerBot < Player
	def initialize(marker, try_limit=3)
		super(marker, try_limit)
	end

	# Need to add move Logic
	def move
	end
end
