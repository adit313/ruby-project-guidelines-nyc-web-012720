class Round < ActiveRecord::Base

	belongs_to :user

	def play_game
		self.introduce_user_to_object
		self.prompt_photo
		self.user_input
		Vision.Take_Photo
		system ("say Thanks I saw it")
		self.check_photo
		input = $prompt.yes?("Do you want to play another round")
		return input
	end

	def introduce_user_to_object
		puts "Thanks for playing #{User.find(self.user_id).name}, please go find me a #{self.object}!"
	end

	def prompt_photo
		puts "When you find the object, show it to me by using the webcam. Press enter when I should take a look"
		puts "It takes me 3 seconds to take a look so hold me steady"
	end

	def user_input
		raw_input = gets.chomp
		return raw_input
	end

	def check_photo
		items_in_photo = Vision.Check_Photo_Stuff
		puts "Thanks, I see #{items_in_photo.join(', ')}"
		if items_in_photo.find{|e| e == self.object}
			self.won = true
			puts "Nice! I see a #{self.object}"
			self.save
		else
			puts "I didn't see a #{self.object}"
			self.won = false
			self.save
		end
	end

end
