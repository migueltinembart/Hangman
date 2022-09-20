require_relative 'display.rb'
require_relative 'player'
require 'pry'
class Game
    include Display
    attr_reader :word_list, :player, :word;

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
        @emptry_string = nil
        @words_min = nil
        @words_max = nil
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
        return char = gets.chomp
    end

    def evaluate_input(char)
        if @word.split.any?(char)
            puts hit(char)
        else
            puts wrong

        end
    end

    def initialize_turns(word)
        @tries = word.length
    end

    def take_turn
        self
    end


    def play_game
        puts how_many_turns(@tries)
        puts show_board(@emptry_string)
        char = ask_for_char
        evaluate_input(char)
    end


    def initialize_game
        puts ask_name_of_player
        name = gets.chomp
        @word = pick_random_word(5,12)
        @tries = word.length
        @player = Player.new(name, @tries)
        @emptry_string = create_empty_word
    end
end