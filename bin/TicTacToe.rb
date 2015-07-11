class TicTacToe

	include GladeGUI
	DEFAULT_VALUE = "None"
	PLAYER1 = "Player One"
	PLAYER2 = "Player Two"

	def before_show()
		@builder["window1"].title = "Tic Tac Toe"
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
		button.label = button.label == "None" ? "YES" : "None"
		@builder["player_label"].label = @builder["player_label"].label == PLAYER1 ? PLAYER2 : PLAYER2

		#VR::msg "#{p button}"
		#VR::msg "#{p @builder['TicTacToe.keys[0]'].label}"
		#VR::msg "@buttons[0]: #{@buttons[0].label} "
		if is_over?
			@builder["window1"].title = "Game Over"
		end
	end

	# Need to add logic
	def valid_move?
	end

	# need to add logic
	def tie?
	end

	# need to add logic
	def game_over
	end

	# need to add logic
	def reset_board
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

