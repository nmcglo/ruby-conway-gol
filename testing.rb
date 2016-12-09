class TestingContainer
  attr_accessor :the_object

  def initialize(obj)
    @the_object = obj
  end

  def get_the_object
    @the_object
  end
end

class TestingObject
  attr_accessor :x, :y, :state

  def initialize(x,y)
    @x = x
    @y = y
    @state = :open
  end

  def update(x,y)
    @x = x
    @y = y
    @state = :closed
  end

  def to_s
    "#{@x},#{@y},#{@state}"
  end
end


obj = TestingObject.new(1,2)
container1 = TestingContainer.new(obj)
container2 = TestingContainer.new(obj)

puts container1.get_the_object
puts container2.get_the_object

obj.update(2,3)

puts container1.get_the_object
puts container2.get_the_object