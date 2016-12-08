require 'tk'

class LifeMatrix
  attr_accessor :cells, :width, :height, :time_alive

  def initialize(w,h)
    @width = w
    @height = h
  end

  def get_number_of_cells()
    @width*@height
  end

  def get_neighbors_of_cell(cell)

  end

  def how_long_alive()
    puts "#{time_alive}"
  end
end

class Cell
  attr_accessor :is_alive,:x,:y

  def initialize(x,y)
    @x = x
    @y = y
    @is_alive = false
  end

  def alive?
    @is_alive
  end



end

canvas = TkCanvas.new

rect = TkcRectangle.new(canvas, '1c', '2c', '3c', '3c',
                 [:outline => 'black', :fill => 'blue'])

puts rect

canvas.pack
Tk.mainloop