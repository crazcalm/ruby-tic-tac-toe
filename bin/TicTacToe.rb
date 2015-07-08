
class TicTacToe #(change name)

	include GladeGUI

	def before_show()
		@button1 = "Hello World"
	  @keys = ["None"] * 9
	end	

	def keys__clicked(button)
		button.label = button.label == "None" ? "YES" : "None"
	end

end

