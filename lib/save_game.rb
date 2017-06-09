# Module for save game and load game logic.
# Used in chess.rb and game.rb
module SaveGame
	def load_game
		saves = Dir.entries('saves').sort_by { |save| File.mtime("saves/#{save}") }
		saves.each { |savegame| puts savegame if savegame[-3..-1] == 'yml' }
		puts "Which game do you want to load?"
		filename = gets.chomp
		until saves.include?(filename + '.yml')
			puts "Please enter a proper filename."
			filename = gets.chomp
		end

		YAML.load_file("saves/#{filename}.yml")
	end

	def save(game)
		Dir.mkdir('saves') unless Dir.exist?('saves')
		puts 'What do you want to call the game?'
		filename = gets.chomp
    saves = Dir.entries('saves')
    while saves.include?("#{filename}.yml")
      puts 'There is a game with the same name. Do you want to overwrite it? (y/n)'
      answer = gets.chomp
      if answer.downcase == 'y'
        break
      elsif answer.downcase == 'n'
        puts 'What do you want to call the game?'
        filename = gets.chomp
      end
    end
    
		File.open("saves/#{filename}.yml", 'w') { |file| file.write(game.to_yaml) }
	end
end
