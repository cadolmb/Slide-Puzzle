class PlayState < GameState

    FONT = Gosu::Font.new(100)
    PAD = 2
    CURSOR = Gosu::Image.new('bin/cursor.png')
    SONG = Gosu::Song.new('bin/play_song.mp3')
    SLIDE_SOUND = Gosu::Sample.new('bin/play_slide.wav')

    def initialize(grid)
        @grid = grid
        @width = Window::WIDTH / grid
        @boxes = {}

        create_grid
        shuffle_grid
    end

    def enter
        SONG.play(true)
    end

    def leave
    end

    def button_down(id)
        if id == Gosu::MS_LEFT
            move_box(clicked_box) if clicked_box
        end
    end

    def update
        GameState.set WinState.new(SONG) if won?
    end

    def draw
        CURSOR.draw($window.mouse_x, $window.mouse_y, 1)

        @boxes.each do |num, pos|
            unless num == @grid**2
                Gosu.draw_rect(
                    pos[0] + PAD, pos[1] + PAD,
                    @width - PAD, @width - PAD, Gosu::Color::CYAN
                )
                FONT.draw_rel(
                    num, pos[0] + @width/2, pos[1] + @width/2,
                    0, 0.5, 0.5, 1, 1, Gosu::Color::BLACK
                )
            end
        end
    end

    def create_grid
        i = 1
        @grid.times do |rows|
            @grid.times do |cols|
                @boxes[i] = [cols*@width, rows*@width]
                i += 1
            end
        end
    end

    def shuffle_grid
        (1000*@grid**2).times do
            move_box(rand(@grid**2 - 1) + 1, false)
        end
    end

    def clicked_box
        x = $window.mouse_x
        y = $window.mouse_y

        @boxes.each do |num, pos|
            if  x > pos[0] && x < pos[0] + @width &&
                y > pos[1] && y < pos[1] + @width
                return num
            end
        end
        return false
    end

    def move_box(num, sound = true)
        if adjacent?(@boxes[num], @boxes[@grid**2])
            boxes = @boxes.to_a
            boxes.each do |box|
                if box[0] == num
                    box[0] = @grid**2
                elsif box[0] == @grid**2
                    box[0] = num
                end
            end
            @boxes = boxes.to_h
            SLIDE_SOUND.play if sound
        end
    end

    def adjacent?(pos1, pos2)
        if  pos1[0] == pos2[0] && (pos1[1] - pos2[1]).abs <= @width ||
            pos1[1] == pos2[1] && (pos1[0] - pos2[0]).abs <= @width
            return true
        end
        return false
    end

    def won?
        if @boxes.keys == @boxes.keys.sort
            return true
        end
        false
    end

end
