require 'tk'

class LifeMatrix
  attr_accessor :cells, :width, :height, :time_alive

  def initialize(w,h)
    @width = w
    @height = h
    @cells = Array.new(@height){|i| Array.new(@width){|j| Cell.new(j,i) }}
  end

  def get_number_of_cells()
    @width*@height
  end

  def how_long_alive()
    puts "#{time_alive}"
  end

  def to_s
    s = ""
    for i in 0..@height
      for j in 0..@width
      s += @cells[j][i].to_s
      end
      s+= "\n"
    end
    return s
  end
end

class Cell
  attr_accessor :is_alive,:x,:y

  def initialize(x,y)
    @x = x
    @y = y
    @state = :dead
  end

  def revive
    @state = :alive
  end

  def die
    @state = :dead
  end

  def alive?
    if @state == :alive
      return true
    else
      return false
    end
  end

  def to_s
    return "[#{@x},#{@y},#{@state}]"
  end
end

# canvas = TkCanvas.new
#
# rect = TkcRectangle.new(canvas, '1c', '2c', '3c', '3c',
#                  [:outline => 'black', :fill => 'blue'])
#
# puts rect
#
# canvas.pack
# Tk.mainloop