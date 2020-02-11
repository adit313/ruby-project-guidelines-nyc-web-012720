class User < ActiveRecord::Base
	has_many :rounds

	def start_game
		new_round = Round.create(user_id: self.id, object: Vision.recognized_objects.sample)
		return new_round
	end

	def score
		wins = self.wins
		losses = self.losses
		puts "You have won #{wins} game(s) and have lost #{losses} game(s)"
	end

	def wins
		wins = 0
		loses = 0
		self.rounds.each{ |round| 
			round.won ? wins += 1 : loses += 1
		}
		return wins
	end

	def losses
		wins = 0
		loses = 0
		self.rounds.each{ |round| 
			round.won ? wins += 1 : loses += 1
		}
		return losses
	end

	def self.top_ten
		sorted_by_wins_array = self.all.sort{|a, b| b.wins <=> a.wins }
		puts "User Name | Wins"
		sorted_by_wins_array.first(10).each {|e| puts "#{e.name} | #{e.wins}"}
	end

end
