require_relative 'display'
require_relative 'player'
require 'pry'
require 'highline'
require "json"

class Game
    include Display
    attr_reader :word_list, :word
    attr_accessor :player, :empty_string, :typed_characters

    def load_text(file)
        words = File.readlines(file)
        words.map! do |line|
            line.chomp 
        end
    end

    def initialize(list)
        @word_list = load_text(list)
        @player = nil
        @word = nil
        @empty_string = nil
        @words_min = nil
        @words_max = nil
        @typed_characters = []
    end

    def pick_random_word(min_length, max_length)
        random_word = word_list[rand(word_list.length) -1]
        if (random_word.length > 12) || (random_word.length < 5)
            pick_random_word(min_length, max_length)
        else
            return random_word
        end
    end

    def create_empty_word
        empty_string = @word.split("")
        empty_string.map! {|char| char = "_"}
        return empty_string
    end

    def ask_for_char
        puts ask_for_pick
        char = gets.chomp.downcase
    end

    def evaluate_input(char)
        if typed_characters.include?(char)
            puts duplicate_character
        elsif char == "!"
            save_game
        elsif char == /[^a-z]/ || char.length > 1 || char.length < 1
            puts invalid_input
        elsif @word.split("").any?(char)
            save_input(char)
            puts hit(char)
            paste_char_in_empty_string(char)
        else
            puts wrong()
            save_input(char)
            deduct_tries(@player)
        end
    end

    def initialize_turns(word)
        @player.tries = word.length
    end

    def deduct_tries(player)
        player.tries -= 1
        puts how_many_turns_left(player.tries)
    end

    def paste_char_in_empty_string(char)
        array_of_occurences = @word.scan(char).uniq
        @word.split("").each_with_index do |character, index|
            @empty_string[index] = character if character == char
        end
    end

    def game_over?
        if player.tries == 0
            return "lose"
        end
        if @empty_string.join("") == @word
            return "win"
        end
    end

    def play_game
        initialize_game
        puts how_many_turns(player.tries)
        turn
    end

    def turn
        puts show_board(@empty_string)
        char = ask_for_char
        evaluate_input(char)
        evaluate(game_over?)
    end


    def initialize_game
        @player = nil
        @typed_characters = []
        puts ask_name_of_player
        name = gets.chomp
        @word = pick_random_word(5,12)
        tries = @word.length
        @player = Player.new(name, tries)
        @empty_string = create_empty_word
    end

    def retry_prompt
        if HighLine.agree("Would you like to play again: ") 
            play_game
        else
            exit 0
        end
    end

    def evaluate(status)
        if status == "lose"
            puts game_over_screen
            puts correct_word(@word)
        elsif status == "win"
            puts winning_screen
        else
            turn
        end
        retry_prompt
    end

    def save_game
        Dir.mkdir("saves") unless Dir.exist?("saves")

        date = DateTime.now.strftime '%d-%m-%Y'
        filename = "saves/#{player.name}-#{date}.json"
        save = {
            name: player.name, 
            tries: player.tries, 
            word: @word,
            empty_string: @empty_string,
            typed_characters: @typed_characters,
        }

        save_file = File.open(filename, "w+")
        save_file.puts save.to_json
        save_file.close

        puts saving_game_in_progress
    end

    def load_save(file)
        save_file = File.read(file)
        save_file = JSON.parse(save_file)
        return save_file
    end

    def show_directory
    end
    def save_input(char)
        @typed_characters << char
        @typed_characters.uniq!
    end

end