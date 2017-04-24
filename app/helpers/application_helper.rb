module ApplicationHelper
	def formatDate(time)
		time.strftime("%Y-%m-%d")
	end

	def formatTime(time)
		time.strftime("%Y-%m-%d %H:%M:%S")
	end
end
