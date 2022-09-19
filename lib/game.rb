class Game

    attr_reader :word_list

    def load_text(file)
        words = File.readlines(file)
        words.map! do |line|
            line.chomp 
        end
    end

    def initialize(list)
        @word_list = load_text(list)
    end

    def pick_random_word
        random_number = rand(word_list.length) -1
        return word_list[random_number]
    end
end