module Display

    def welcome_screen
        "Welcome to Hangman\n"
    end

    def initialize_game_text
        "Game initialized...\n"
    end

    def ask_name_of_player
        "What is your name\n"
    end

    def how_many_turns(tries)
        "you start with #{tries} tries\n"
    end

    def how_many_turns_left(tries)
        "you got #{tries} left...\n"
    end

    def hit(char)
        "you guessed #{char} right, Nice!\n"
    end

    def show_board(word_array)
        "#{word_array.join(" ")}"
    end

    def ask_for_pick
        "Pick a character...\n"
    end

    def wrong
        "Wrong input you lose a life\n"
    end

    def invalid_input
        "invalid input\n"
    end

    def game_over_screen
        "You lose\n"
    end

    def duplicate_character
        "you cannot type character already passed\n"
    end

    def correct_word(word)
        "the correct answer would have been... #{word}\n"
    end

    def winning_screen
        "You won\n"
    end

    def saving_game_in_progress
        "Your save state has been has been saved...\n"
    end


end