# First we can retrieve the time/distance between the origin and all the points to visit.
# Then ....

class GraphBuilder
  attr_reader :points, :origin_to_other_points

  def initialize(origin, points_to_visit=[])
    @points = PointsToVisit.new(origin, points_to_visit)
    @origin_to_other_points = {}
  end

  def get_distance_from_origin_to_other_points
    origin = points[:origin]
    points_to_visit = points[:points_to_visit]

    # Simplify. Too much going on here.

    points_to_visit.each do |point|
      origin_to_other_points[[origin, point]] = get_distance(origin, destination)
    end
  end

  private

  def get_distance(origin, distance)
    MapsApiCaller.new(origin, destination)
  end
end