require_relative '../config/environment'

system('export GOOGLE_APPLICATION_CREDENTIALS="/Users/aditpatel/flatironcode/projects/mod1project.json"')

$prompt =  TTY::Prompt.new
$pastel = Pastel.new

system('clear')

system('say Hi there     please enter your name')
name = $prompt.ask("Hi there! Please enter your" + $pastel.bright_cyan.bold(" name ") + "to get started:")
system('clear')

system('say thanks #{name}, what would you like to do today')

run = true

main_user = User.find_or_create_by(name: name)


while run do 

input = $prompt.select("Thanks " + $pastel.bright_cyan.bold(name) + ' what would you like to do today?') do |menu|
	menu.choice 'Check Scores', 1
	menu.choice 'Play a Game', 2
	menu.choice 'Check Your Feelings', 4
	menu.choice 'Exit', 3
	menu.choice 'Clear My Scores', 5
end

system('clear')

case input
when 2
	continue = true
	while continue do
		new_round = main_user.start_game()
		continue = new_round.play_game()
	end
when 1
	system('say here are the scores')
	User.top_ten
when 3
	run = false
when 4
	puts "Smile!!"
	system('say Cheese')
	photo = Vision.Take_Photo
	pp Vision.Check_Photo_Faces(photo)
when 5
	Round.where(user_id: main_user.id).destroy_all
	puts 'Your score has been cleared'
	system('say your score has been cleared, you are now dead to me')
end


end

system('say bye')
puts "Bye!"