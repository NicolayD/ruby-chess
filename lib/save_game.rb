# Module for save game and load game logic.
# Used in chess.rb and game.rb
module SaveGame
	def load_game
		saves = Dir.entries("saves")
		saves.each { |savegame| puts savegame if savegame[-3..-1] == 'yml' }
		puts "Which game do you want to load?"

		filename = gets.chomp
		until saves.include?(filename + ".yml")
			puts "Please enter a proper filename."
			filename = gets.chomp
		end

		loaded_game = YAML::load_file("saves/#{filename}.yml")
	end

	def save
		Dir.mkdir("saves") unless Dir.exist?("saves")
		puts "What do you want to call the game?"
		filename = gets.chomp
		File.open("saves/#{filename}.yml", "w") { |file| file.write(self.to_yaml) }
	end
end