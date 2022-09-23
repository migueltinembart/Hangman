class Player

    attr_reader :name
    attr_accessor :tries
    
    def initialize(name, tries)
        @name = name
        @tries = tries
    end
end