class Cell
  attr_reader :coordinate,
              :ship,
              :is_fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @is_fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    if @ship
      @ship.hit
    end
    @is_fired_upon = true
  end

  def fired_upon?
    @is_fired_upon
  end

  def render(show_ship=false)
    if fired_upon?
      ship_is_fired_upon
    elsif show_ship && !empty?
      "S"
    else
      "."
    end
  end

  def ship_is_fired_upon
    if !empty?
      cell_has_ship
    else
      "M"
    end
  end

  def cell_has_ship
    if @ship.sunk?
      "X"
    else
      "H"
    end
  end

end
