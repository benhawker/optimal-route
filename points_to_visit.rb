# +PointToVisit+ - the entry point for defining the points you seek to visit.

# Usage: PointsToVisit.new("Brooklyn", ["Queens", "Flushing", "La Guardia"])

class PointsToVisit
  attr_reader :origin, :points_to_visit

  # Error that is raised when the location is not recognised by the Google Maps API.
  class InvalidLocationGiven < StandardError
    def initialize(location)
      super("Your location: #{location} is not recognised by Google Maps.")
    end
  end

  def initialize(origin, points_to_visit=[])
    @origin = origin
    @points_to_visit = points_to_visit

    valid_locations?
  end

  def response
    {
      origin: origin,
      points_to_visit: points_to_visit
    }
  end


  private

  def valid_locations?
    tmp = points_to_visit
    tmp << origin

    tmp.each do |location|
      valid_location?(location)
    end
  end

  def valid_location?(location)
    #raise InvalidLocationGiven.new(location) unless "call api to validate"
  end

end