class TicTacToe

	include GladeGUI

	DEFAULT_VALUE = "None"
	PLAYER1 = "Player One"
	PLAYER2 = "Player Two"
	TITLE = "Tic Tac Toe"
	GAME_OVER = "Game Over"

	def before_show()
		@builder["window1"].title = TITLE
	  @keys = [DEFAULT_VALUE] * 9
		@builder["player_label"].label = PLAYER1
		@buttons = [
				@builder["TicTacToe.keys[0]"],
				@builder["TicTacToe.keys[1]"],
				@builder["TicTacToe.keys[2]"],
				@builder["TicTacToe.keys[3]"],
				@builder["TicTacToe.keys[4]"],
				@builder["TicTacToe.keys[5]"],
				@builder["TicTacToe.keys[6]"],
				@builder["TicTacToe.keys[7]"],
				@builder["TicTacToe.keys[8]"]
				]
	end	

	def keys__clicked(button)
		

		if valid_move?(button) # Checks for valide move
			button.label = button.label == "None" ? "YES" : "None"

			if tie?
				tie
		else
			try_again
		end
		@builder["player_label"].label = @builder["player_label"].label == PLAYER1 ? PLAYER2 : PLAYER2

		#VR::msg "#{p button}"
		#VR::msg "#{p @builder['TicTacToe.keys[0]'].label}"
		#VR::msg "@buttons[0]: #{@buttons[0].label} "
		if is_over?
			game_over
		end
	end

	# I need to create bot move method...
	def bot_move(player)
	end

	# Need to add logic
	def valid_move?(button)
		result = button.label == DEFAULT_VALUE ? false : true
		result
	end

	def next_player
		@builder["player_label"].label = @builder["player_label"].label == PLAYER1 ? PLAYER2
	end

	# need to add logic
	def tie?
		result = true
		
		@buttons.each do |button|
			result = true if button.label == DEFAULT_VALUE
		end
		
		result
	end

	def tie
		VR::msg "Game has ended in a tie!"
		game_over
		play_again?
	end

	# need to add logic
	def game_over
		@builder["window1"].title = GAME_OVER
	end

	# This method is needed to determine of the player would
	# like to play again.
	# Need to learn "y/n" dialog box
	def play_again?
		VR::msg "Would you like to play again?"
	end

	# This method is needed for when invalid moves are made and
	# the same player must go again.
	# I should add a mistake limit...
	def try_again
		VR::msg "That was in invalide move!"		
	end

	# need to add logic
	def reset_board
		@buttons.each do |button|
			button.label = DEFAULT_VALUE
		end
		@builder["window1"].title = TITLE
	end

	def is_over?
		
		# What I am returning
		answer = false

		# Horizontal cases
		case1 = @buttons[0..2]
		case2 = @buttons[3..5]
		case3 = @buttons[6..8]

		# Vertical cases
		case4 = [@buttons[0], @buttons[3], @buttons[6]]
		case5 = [@buttons[1], @buttons[4], @buttons[7]]
		case6 = [@buttons[2], @buttons[5], @buttons[8]]

		# Diagonal cases
		case7 = [@buttons[0], @buttons[4], @buttons[8]]
		case8 = [@buttons[2], @buttons[4], @buttons[6]]

		cases = [case1, case2, case3] +
					[case4, case5, case6] +
						[case7, case8]
		VR::msg "#{@buttons}"
		cases.each do |items|
			if items[0].label != DEFAULT_VALUE
				if items[0].label == items[1].label && items[0].label == items[2].label
					answer = true
					return answer
				end
			end
		end
		answer
	end

end

