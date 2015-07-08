
class TicTacToe #(change name)

	include GladeGUI

	def before_show()
		@builder["window1"].title = "Tic Tac Toe"
	  @keys = ["None"] * 9
		@builder["player_label"].label = "Default Value"
	end	

	def keys__clicked(button)
		button.label = button.label == "None" ? "YES" : "None"
		@builder["player_label"].label = @builder["player_label"].label == "Player1"? "Player2" : "Player1"
	end

end

