require 'tk'

class LifeMatrix
  attr_accessor :cells, :width, :height, :time_alive

  def initialize(w,h)
    @width = w
    @height = h
    @cells = Array.new(@height){|i| Array.new(@width){|j| Cell.new(j,i) }}

    @cells.each do |row|
      row.each do |cell|
        cell_x = cell.get_x
        cell_y = cell.get_y
        neighbors = []

        # left neighbor
        if cell_x > 0
          neighbors.push(@cells[cell_y][cell_x-1])
        end
        # upper neighbor
        if cell_y > 0
          neighbors.push(@cells[cell_y-1][cell_x])
        end
        # right neighbor
        if cell_x < @width -1
          neighbors.push(@cells[cell_y][cell_x+1])
        end
        # lower neighbor
        if cell_y < @height -1
          neighbors.push(@cells[cell_y+1][cell_x])
        end
        cell.set_neighbors(neighbors)
        # puts "Cell: #{cell.get_x}, #{cell.get_y}"
      end
    end
  end

  def tick
    @cells.each do |row|
      row.each do |cell|
        cell.tic
      end
    end

    # synchronization separator - do all tics and then do all tocs
    @cells.each do |row|
      row.each do |cell|
        cell.toc
      end
    end
  end

  def flip_tick
    @cells.each do |row|
      row.each do |cell|
        cell.debug_flip
      end
    end
  end

  def get_number_of_cells()
    @width*@height
  end

  def how_long_alive()
    puts "#{time_alive}"
  end

  def get_height
    return @height
  end

  def get_width
    return @width
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
  attr_accessor :x,:y,:neighbors,:state,:next_state

  def initialize(x,y)
    @x = x
    @y = y
    rand_draw = rand
    if rand_draw > 0.55
      @state = :alive
    else
      @state = :dead
    end

    @next_state = :undefined
    @neighbors = []
  end

  def set_neighbors(neighbors)
    @neighbors = neighbors
  end

  def set_next_state(next_state)
    @next_state=next_state
  end

  def get_num_live_neighbors
    number_of_live_neighbors = 0
    @neighbors.each do |neighbor|
      if neighbor.alive?
        number_of_live_neighbors+= 1
      end
    end
    return number_of_live_neighbors
  end

  def tic
    number_of_live_neighbors = get_num_live_neighbors

    if self.alive?
      if number_of_live_neighbors < 2
        set_next_state(:dead)
      elsif number_of_live_neighbors > 3
        set_next_state(:dead)
      else
        set_next_state(:alive)
      end
    else
      if number_of_live_neighbors == 3
        set_next_state(:alive)
      else
        set_next_state(:dead)
      end
    end
  end

  def toc
    if @next_state != :undefined
      @state = @next_state
    else
      puts "Whoops you're becoming undefined!"
    end
    @next_state = :undefined
  end

  def alive?
    if @state == :alive
      return true
    else
      return false
    end
  end

  def get_x
    return @x
  end

  def get_y
    return @y
  end

  def to_s
    return "[#{@x},#{@y},#{@state}]"
  end

  def debug_flip
    if @state == :alive
      @state = :dead
    else
      @state = :alive
    end
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