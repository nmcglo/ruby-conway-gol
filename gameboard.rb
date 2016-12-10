require_relative 'life_matrix'


class Gameboard
  attr_accessor :root,:canvas,:life_matrix


  def initialize(life_matrix, parent)
    @root = parent
    @life_matrix = life_matrix

    @canvas = TkCanvas.new(parent) do
      place('height' => ($height * $cell_size), 'width' => ($width * $cell_size))
    end
  end

  def draw
    life_matrix.cells.each do |row|
      row.each do |cell|
        xmin = $cell_size*cell.get_x
        ymin = $cell_size*cell.get_y
        if cell.alive?
          TkcRectangle.new(canvas, xmin, ymin, xmin+$cell_size, ymin+$cell_size, ['outline' => 'black','fill'=>'black'])
        else
          TkcRectangle.new(canvas, xmin, ymin, xmin+$cell_size, ymin+$cell_size, ['outline' => 'white','fill'=>'white'])
        end
        # TkcRectangle.new(canvas, xmin, ymin, xmin+$cell_size, ymin+$cell_size, ['outline' => 'black','fill'=>'white'])

      end
    end
    life_matrix.tick
    @canvas.update
    @canvas.after(30,self.draw)
  end

end


$cell_size = 10
$width = 50
$height = 30

root = TkRoot.new do
  title 'Conway'
  minsize($cell_size*$width,$cell_size*$height)
end


thegame = Gameboard.new(LifeMatrix.new($width,$height),root)
thr2 = Thread.new {Tk.mainloop}
thr1 = Thread.new {thegame.draw}


thr2.join()
thr1.exit()


