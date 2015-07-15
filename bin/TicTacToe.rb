require File.join(File.dirname(__FILE__), 'players')
require File.join(File.dirname(__FILE__), 'stack')

class TicTacToe

	include GladeGUI

	DEFAULT_VALUE = " "
	PLAYER1 = "Player One"
	PLAYER2 = "Player Two"
	TITLE = "Tic Tac Toe"
	GAME_OVER = "Game Over"

	def before_show()
		@player1 = Player.new("X", 3, "Player1")
		@player2 = Player.new("O", 3, "Player2")
		@stack = Stack.new
		@builder["window1"].title = TITLE
	  @keys = [DEFAULT_VALUE] * 9
		@builder["player_label"].label = @player1.name
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
				
		# game logic (High level)
		if valid_move?(button) # Checks for valide move
			make_move(button)

			if is_over?
				winner_is
				game_over
			elsif tie?
				tie
			else
				next_player
			end

		else
			try_again
		end
	end

	def make_move(button)
		button.label = current_player_mark
		@stack.push(button)
	end

	def file_undo_activate(menuitem, data=nil)
		if @stack.empty?
			VR::msg "Cannot undo move"
		else
			button = @stack.pop
			button.label = DEFAULT_VALUE
			next_player
			VR::msg "Move has been undone"
		end
	end

	def current_player_mark
		@builder["player_label"].label == @player1.name ? @player1.move : @player2.move
	end

	def opponent_player_mark
		@builder['player_label'].label == @player1.name ? @player2.move : @player1.move
	end

	# I need to create bot move method...
	def bot_move(player)
	end

	def board_empty?
		result = true
		@buttons.each do |button|
			unless button.label == DEFAULT_VALUE
				result = false
			end
		end
	result
	end

	# Need to add logic
	def valid_move?(button)
		result = button.label == DEFAULT_VALUE ? true : false
		result
	end

	def next_player
		if @builder['player_label'].label == @player1.name
			@builder['player_label'].label = @player2.name
		else
			@builder['player_label'].label = @player1.name
		end
	end

	def random_move(marker)
		# add a valid move check!
		@buttons[rand(9)].label == marker
		# Add board empty logic here and act accordingly
	end

	def opponent_is_close_to_winning(marker)
		result = false
		
		# Iterate through the cases and see if 2 of 3 are the marker
	end

	def stop_opponent_from_winning(opponent_marker, bot_marker)
		# Iterate through the cases and and try to stop him/her from winning!
	end

	def can_i_win?(marker)
		# The same as opponent_is_close_to_winning. Make one method for this logic
	end

	def play_winning_move(marker)
		# The same as stop_opponent_from_winning. Make one method for this logic
	end

	# The bot needs to be able to be able to move too!
	# add logic
	def bot_move
		opponent_mark = opponent_player_mark
		bot_mark = current_player_mark

		#case1: Board is empty
		if board_empty?
			randome_move(bot_mark)
		elsif opponent_is_close_to_winning(opponent_mark) # opponent has two in a row
			stop_opponent_from_winning
		elsif can_i_win?
			play_winning_move(bot_marker)
		else
			random_move(bot_mark)
		end
	end

	# need to add logic
	def tie?
		result = true
		
		@buttons.each do |button|
			result = false if button.label == DEFAULT_VALUE
		end
		
		result
	end

	def tie
		VR::msg "Game has ended in a tie!"
		game_over
	end

	# need to add logic
	def game_over
		@builder["window1"].title = GAME_OVER
		play_again?
	end

	# This method is needed to determine of the player would
	# like to play again.
	# Need to learn "y/n" dialog box
	def play_again?
		VR::Dialog.ok_box("Would you like to play again") == true ? reset_board : quit
	end

	# This method is needed for when invalid moves are made and
	# the same player must go again.
	# I should add a mistake limit...
	def try_again
		VR::msg "That was in invalide move!"		
	end

	def quit
		VR::msg "Qutting"
		destroy_window
	end

	# need to add logic
	def reset_board
		@buttons.each do |button|
			button.label = DEFAULT_VALUE
		end
		@builder["window1"].title = TITLE
	end

	def winner_is
		VR::msg "The winner is #{@builder['player_label'].label}!"
	end

	def file_quit_activate(menuitem, data=nil)
		quit
	end

	def file_rules_activate(menuitem, data=nil)
		VR::msg "Add game rules"
	end

	def file_about_activate(menuitem, data=nil)
		VR::msg "Add an about Page"
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

