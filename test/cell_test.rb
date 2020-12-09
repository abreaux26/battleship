require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @cell = Cell.new("B4")
  end

  def test_if_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_readable_attributes
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
  end

  def test_is_ship_empty
    assert_equal true, @cell.empty?
  end

  def test_place_ship
    @cell.place_ship(@cruiser)
    
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end
end
