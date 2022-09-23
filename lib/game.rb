require_relative 'display'
require_relative 'player'
require 'pry'
require 'highline'
require 'json'

class Game
    include Display
    attr_reader :word_list, :word
    attr_accessor :player, :empty_string

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
        if @word.split("").any?(char)
            puts hit(char)
            paste_char_in_empty_string(char)
        elsif char == "!"
            save_game
        elsif char == /[^a-z]/
            puts invalid_input
        else
            puts wrong()
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
            false
        end
        if @empty_string == @word
            true
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
        evaluate(@empty_string)
    end

    def evaluate(string)
        turn
    end


    def initialize_game
        puts ask_name_of_player
        name = gets.chomp
        @word = pick_random_word(5,12)
        tries = @word.length
        @player = Player.new(name, tries)
        @empty_string = create_empty_word
    end

    def retry_prompt
        puts game_over_screen
        if HighLine.agree("Would you like to play again ") 
            play_game
        else
            exit!
        end
    end

    def save_game

    end

    def save_input(char)

    end

end