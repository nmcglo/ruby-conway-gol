require_relative "life_matrix"
require 'test/unit'

# class TestCell < Test::Unit::TestCase
#
#   def test_cell
#     my_test_cell = Cell.new(1,2)
#     assert_equal(1,my_test_cell.x)
#     assert_equal(2,my_test_cell.y)
#   end
# end

class TestMatrix < Test::Unit::TestCase

  def test_matrix
    my_test_matrix = LifeMatrix.new(5,10)
    puts my_test_matrix
  end
end