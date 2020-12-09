require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @ship = Ship.new("cruiser",3)
  end

  def test_it_exist
    assert_instance_of Ship, @ship
  end

  def test_if_it_has_readable_attributes
    assert_equal "cruiser", @ship.name
    assert_equal 3, @ship.length
    assert_equal 3, @ship.health
  end

  def test_if_ship_hit
    assert_equal 3, @ship.health
    @ship.hit
    assert_equal 2, @ship.health
  end

   def test_if_ship_has_sunk?
     assert_equal false, @ship.sunk?
     3.times do
       @ship.hit
     end
     assert_equal true, @ship.sunk?
   end
end
