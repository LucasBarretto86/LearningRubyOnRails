class Player

  attr_reader :score
  def initialize
    @sprite = Gosu::Image.new("images/player.png", retro: true)
    @blip = Gosu::Sample.new("sfx/blip.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 2.5
  end

  def turn_right
    @angle += 2.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.3)
    @vel_y += Gosu.offset_y(@angle, 0.3)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.90
    @vel_y *= 0.90
  end

  def score
    @score
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 20
        @score += 10
        @blip.play
        true
      else
        false
      end
    end
  end

  def draw
    @sprite.draw_rot(@x, @y, 1, @angle)
  end
end