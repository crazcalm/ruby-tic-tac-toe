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
			players << Player.new("X", "Player1", false)
		else
			players << Player.new("X", "Player1", true)
		end

		if player2 == "human"
			players << Player.new("O", "Player2", false)
		else
			players << PlayerBot.new("O", "Player2", true)
		end

	else
		# Case2
		if player1 == "human"
			players << Player.new("O", "Player1", false)
		else
			players << PlayerBot.new("O", "Player1", true)
		end

		if player2 == "human"
			players << Player.new("X", "Player2", false)
		else
			players << PlayerBot.new("X", "Player2", true)
		end
	end

	players
end

class Player
	attr_reader :marker, :bot
	attr_accessor :try_limit, :name

  def initialize(marker, name="Player1", bot=false)
		@marker = marker
		@try_limit = try_limit
		@name = name
		@bot = bot
	end

	def move
		@marker
	end

	def invalid_move
		@try_limit -=1
	end
end
