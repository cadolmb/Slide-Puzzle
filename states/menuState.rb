class MenuState < GameState

    WIDTH = Window::WIDTH
    HEIGHT = Window::HEIGHT
    FONT = Gosu::Font.new(100)
    PAD = HEIGHT / 12
    HEADER = 'Slide Puzzle'
    SUBHEADER = 'Choose Difficulty'
    OPTIONS = [
        '3x3',
        '4x4',
        '5x5',
        '6x6',
        'Quit'
    ]

    WHITE = Gosu::Color::WHITE
    YELLOW = Gosu::Color::YELLOW

    SONG = Gosu::Song.new('bin/menu_song.mp3')
    MOVE_SOUND = Gosu::Sample.new('bin/menu_move.wav')
    SELECT_SOUND = Gosu::Sample.new('bin/menu_select.wav')

    def initialize
        @select = 0
    end

    def enter
        SONG.play(true)
    end

    def leave
        SONG.stop
    end

    def button_down(id)
        case id
        when Gosu::KB_UP
            if @select > 0
                @select -= 1
                MOVE_SOUND.play
            end
        when Gosu::KB_DOWN
            if @select < 4
                @select += 1
                MOVE_SOUND.play
            end
        when Gosu::KB_RETURN
            SELECT_SOUND.play
            select(@select)
        end
    end

    def select(option)
        case option
        when 0
            GameState.set PlayState.new(3)
        when 1
            GameState.set PlayState.new(4)
        when 2
            GameState.set PlayState.new(5)
        when 3
            GameState.set PlayState.new(6)
        when 4
            close
        end
    end

    def update
    end

    def draw
        FONT.draw_rel(
            HEADER, WIDTH/2, HEIGHT/2 - PAD*3,
            0, 0.5, 0.5, 1, 1, YELLOW
        )
        FONT.draw_rel(
            SUBHEADER, WIDTH/2, HEIGHT/2 - PAD,
            0, 0.5, 0.5, 0.4, 0.4, WHITE
        )

        OPTIONS.each_with_index do |option, i|
            if i == @select
                color = YELLOW
                scl = 0.4
            else
                color = WHITE
                scl = 0.3
            end
            FONT.draw_rel(
                option, WIDTH/2, HEIGHT/2 + PAD*i, 0, 0.5, 0.5, scl, scl, color
            )
        end
    end

end
