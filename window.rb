class Window < Gosu::Window

    WIDTH = 640
    HEIGHT = 640
    TITLE = 'Slide Puzzle'

    attr_accessor :state

    def initialize
        super WIDTH, HEIGHT
        self.caption = TITLE
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        end

        @state.button_down(id)
    end

    def update
        @state.update
    end

    def draw
        @state.draw
    end

end
