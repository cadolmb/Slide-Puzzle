class WinState < GameState

  def initialize(song)
    @font = Gosu::Font.new(100)
    @msg = "You Win"
    @start_time = Gosu.milliseconds
    @time_passed = 0
    @end_time = 4000

    @song = song
  end

  def enter
  end

  def leave
      @song.stop
  end

  def button_down(id)
  end

  def update
    @time_passed = Gosu.milliseconds - @start_time
    if @time_passed > @end_time
      GameState.set MenuState.new
    end
  end

  def draw
    a = Math.sin((Math::PI * @time_passed - 1000) / (@end_time - 1000))*200
    color = Gosu::Color.new(a, 0, 255, 0)
    @font.draw_rel(
      @msg, Window::WIDTH / 2, Window::WIDTH / 2, 0, 0.5, 0.5, 1, 1, color
    )
  end

end
