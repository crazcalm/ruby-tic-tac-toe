require File.join(File.dirname(__FILE__), 'players')
require File.join(File.dirname(__FILE__), 'stack')

class TicTacToe

	include GladeGUI

	DEFAULT_VALUE = " "
	PLAYER1 = "Player One"
	PLAYER2 = "Player Two"
	TITLE = "Tic Tac Toe"
	GAME_OVER = "Game Over"
  ABOUT_PAGE = "\t    Author: \tMarcus 'crazcalm' Willock\nSource Code:  https://github.com/crazcalm/ruby-tic-tac-toe"

	def before_show()
		@player1 = Player.new("X", "Player1", false)
		@player2 = Player.new("O", "Player2", true)
		@stack = Stack.new
		@builder["window1"].title = TITLE
	  @keys = [DEFAULT_VALUE] * 9
		@builder["player_label"].label = @player1.name
		@one_player_mode = true
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
		
		# Methods used to set up the game
		set_game_mode
		initialize_players
	end

	def set_game_mode
		@one_player_mode = VR::Dialog.ok_box("'OK' == 1 player mode\n'Cancel' == 2 player mode")
	end

	def file_select_mode_activate(menuitem, data=nil)
		set_game_mode
		reset_board
		initialize_players
		if current_player_is?(@player2)
			next_player
		end
	end

	def initialize_players
		if @one_player_mode
			@player1, @player2 = players_factory("human", "bot")
		else
			@player1, @player2 = players_factory("human", "human")
		end
	end

	def keys__clicked(button)
				
		# game logic (High level)
		if valid_move?(button) # Checks for valide move
			make_move(button)
			game_play_steps
		else
			try_again
		end
	end

	def game_play_steps
		if is_over?
			winner_is
			game_over
		elsif tie?
			tie
		else
			next_player
		end
	end

	def make_move(button)
		button.label = current_player_mark
		@stack.push(button)
	end

	def _undo
		if @stack.empty?
			#VR::msg "Cannot undo move"
		else
			button = @stack.pop
			button.label = DEFAULT_VALUE
			#VR::msg "Move has been undone"
		end
	end

	def file_undo_activate(menuitem, data=nil)
		if @one_player_mode
			_undo
			_undo
		else
			_undo
			unless @stack.empty?
				next_player
			end
		end
	end

	def current_player_is_a_bot?
		@builder["player_label"].label == @player1.name ? @player1.bot : @player2.bot
	end

	def current_player_mark
		@builder["player_label"].label == @player1.name ? @player1.move : @player2.move
	end

	def opponent_player_mark
		@builder['player_label'].label == @player1.name ? @player2.move : @player1.move
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

	def valid_move?(button)
		result = button.label == DEFAULT_VALUE ? true : false
		result
	end

	def current_player_is?(player)
		@builder['player_label'].label == player.name ? true : false
	end

	def next_player
		if @builder['player_label'].label == @player1.name
			@builder['player_label'].label = @player2.name
		else
			@builder['player_label'].label = @player1.name
		end

		if current_player_is_a_bot?
			bot_move
		end
	end

	def random_move
		# options
		numbers = (0...9).to_a
		rand_num = numbers.sample
		
		# Chooses a valid move
		while not valid_move?(@buttons[rand_num]) do 
			#VR::msg "Button #{@buttons[rand_num]} num: #{rand_num}"
			rand_num = numbers.sample
		end
		make_move(@buttons[rand_num])
	end

	def close_to_winning?(marker)
		result = false		
		cases = board_cases

		cases.each do |items|

      testing = [items[0].label, items[1].label, items[2].label]
      
			if testing.count(marker) == 2 && testing.count(DEFAULT_VALUE) == 1
				result = true
				return result
			end
		end
		result
	end

	def opponent_is_close_to_winning
		opponent_marker = opponent_player_mark
		close_to_winning?(opponent_marker)
	end

	def winning_move
		cases = board_cases
		marker = current_player_mark

		cases.each do |_items|
      items = [_items[0].label, _items[1].label, _items[2].label]
			if items.count(marker) == 2 && items.count(DEFAULT_VALUE) == 1
				index = items.index(DEFAULT_VALUE)
				make_move(_items[index])
				break
			end
		end
	end

	def stop_opponent_from_winning
		# Iterate through the cases and and try to stop him/her from winning!
		cases = board_cases
		my_marker = current_player_mark
		opponent_marker = opponent_player_mark

		cases.each do |_items|
      items = [_items[0].label, _items[1].label, _items[2].label]
			if items.count(opponent_marker) == 2 && items.count(DEFAULT_VALUE) == 1
				index = items.index(DEFAULT_VALUE)
				make_move(_items[index])
				break
			end				 
		end
		
	end

	def can_i_win?
		my_marker = current_player_mark
		close_to_winning?(my_marker)
	end

	def bot_move

		#case1: Board is empty
		if board_empty?
			#VR::msg "Board is empty"
			random_move
		elsif can_i_win?
			#VR::msg "Can I Win?"
			winning_move
		elsif opponent_is_close_to_winning # opponent has two in a row
			#VR::msg "MY Oppenent is close to winning"
			stop_opponent_from_winning
		else
			#VR::msg "The else case"
			random_move
		end
	
		game_play_steps
	end

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

	def game_over
		@builder["window1"].title = GAME_OVER
		play_again?
	end

	# This method is needed to determine of the player would
	# like to play again.
	def play_again?
		play_again = VR::Dialog.ok_box("Would you like to play again")

		if play_again
			reset_board
			if current_player_is_a_bot?
				bot_move
			end
		else
			quit
 		end
	end

	# This method is needed for when invalid moves are made and
	# the same player must go again.
	# I should add a mistake limit...
	def try_again
		VR::msg "That was in invalide move!"		
	end

	def quit
		#VR::msg "Qutting"
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

	def file_about_activate(menuitem, data=nil)
		VR::msg "#{ABOUT_PAGE}"
	end

	def board_cases
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

		cases
	end

	def is_over?
		
		# This gets returned
		result = false

		cases = board_cases

		cases.each do |items|
			if items[0].label != DEFAULT_VALUE
				if items[0].label == items[1].label && items[0].label == items[2].label
					result = true
					return result
				end
			end
		end
		result
	end

  def board_state
    state = ""
    @buttons.each_with_index do |item, index|
      if (index + 1) % 3 == 0
        state += " #{item.label}\n"
        state += "---------------\n"
      else
        state += " #{item.label} | "
      end
    end
    VR::msg state
  end

end

