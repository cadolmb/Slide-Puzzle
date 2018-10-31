class GameState

    def self.set(new_state)
        $window&.state&.leave
        $window.state = new_state
        new_state.enter
    end

    def enter
    end

    def leave
    end

    def button_down(id)
    end

    def update
    end

    def draw
    end

end
