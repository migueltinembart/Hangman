class Player

    attr_reader :name
    
    def initialize(name, tries)
        @name = name
        @tries = tries
    end
end