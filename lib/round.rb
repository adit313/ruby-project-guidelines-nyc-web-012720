class Round < ActiveRecord::Base

	belongs_to :user

	def play_game
		self.introduce_user_to_object
		self.prompt_photo
		photo = Vision.Take_Photo
		Vision.clear
		# box = TTY::Box.success("Let me see what's in the photo")
		box = TTY::Box.frame(width: 126, height: 10, align: :center, padding: 4, border: {type: :thick}, style: {fg: :bright_black, bg: :bright_cyan}) do
			"Let me see what's in the photo"
		end
		print box
		self.check_photo(photo)
		input = $prompt.yes?("Do you want to play another round")
		return input
	end

	def introduce_user_to_object
		puts "Thanks for playing #{User.find(self.user_id).name}, please go find me a:"
		star_wars = TTY::Font.new(:standard)
		box = TTY::Box.frame(width: 126, height: 15, align: :center, padding: 4, border: {type: :thick}, style: {fg: :bright_black, bg: :bright_cyan}) do
			star_wars.write(self.object)
		end
		print box
	end

	def prompt_photo
		puts "When you find the object, take a photo with your camera, and AIRDROP it onto Adit's MacBook Pro"
		puts "You only have 90 Seconds!!!"
		puts "P.S. Sorry Android users, but you can't play this game yet!"
	end

	def user_input
		raw_input = gets.chomp
		return raw_input
	end

	def check_photo(photo)
		items_in_photo = Vision.Check_Photo_Stuff(photo)
		puts "Thanks, I see #{items_in_photo.join(', ')}"
		if items_in_photo.find{|e| e == self.object}
			self.won = true
			puts "Nice! You got the #{self.object}"
			self.save
		else
			puts "I didn't see a #{self.object}"
			self.won = false
			self.save
		end
	end

end
