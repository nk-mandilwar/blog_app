module CommentsHelper

	def calc_left_margin(level)
		l = 100 
		while level >= 0 
			l = l * 0.9 
			level = level - 1 
		end
		l 
	end

end