module Display

    def welcome_screen
        "Welcome to Hangman"
    end

    def initialize_game_text
        "Game initialized... "
    end

    def ask_name_of_player
        "What is your name"
    end

    def how_many_turns(tries)
        "you start with #{tries} many tries"
    end

    def how_many_turns_left(tries)
        "you got #{tries} left..."
    end

    def hit(char)
        "you guessed #{char} right, Nice!"
    end

    def show_board(word_array)
        word_array.join(" ")
    end

    def ask_for_pick
        "Pick a character..."
    end

    def wrong
        "Wrong input you lose a life"
    end


end