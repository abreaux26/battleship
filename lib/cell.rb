class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
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
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(show_ship=false)
    if fired_upon?
      if !empty?
        if @ship.sunk?
          "X"
        else
          "H"
        end
      else
        "M"
      end
    elsif show_ship && !empty?
      "S"
    else
      "."
    end
  end
end
