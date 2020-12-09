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

  def test_is_cell_fired_upon?
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_cell_render
    assert_equal ".", @cell.render
  end

  def test_render_after_a_missed_fire
    @cell.fire_upon

    assert_equal "M", @cell.render
  end

  def test_render_ship_is_hit
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal "H", @cell.render
  end

  def test_render_after_ship_is_sunk
    @cell.place_ship(@cruiser)
    3.times do
      @cell.fire_upon
    end

    assert_equal "X", @cell.render
  end

  def test_render_show_ship
    @cell.place_ship(@cruiser)

    assert_equal "S", @cell.render(true)
  end
end
