# First we can retrieve the time/distance between the origin and all the points to visit.
# Then ....

class GraphBuilder
  attr_reader :points, :graph_array

  def initialize(origin, points_to_visit=[])
    @points = PointsToVisit.new(origin, points_to_visit).response
    @graph_array = []
  end

  def get_distances
    get_distance_from_origin_to_other_points
    get_distance_from_other_points_to_origin
    get_distance_from_other_points_to_other_points

    graph_array
  end

  def get_distance_from_origin_to_other_points
    origin = points[:origin]
    points_to_visit = points[:points_to_visit]

    points_to_visit.each do |point|
      graph_array << { :origin => origin, :destination => point }.merge!(get_distance(origin, point))
    end

    graph_array
  end

  def get_distance_from_other_points_to_origin
    origin = points[:origin]
    points_to_visit = points[:points_to_visit]

    points_to_visit.each do |point|
      graph_array << { :origin => point, :destination => origin }.merge!(get_distance(point, origin))
    end

    graph_array
  end

  def get_distance_from_other_points_to_other_points
    points_to_visit = points[:points_to_visit]

    points_to_visit.each do |point|
      points_to_visit.each do |inner_point|
        unless point == inner_point
          graph_array << { :origin => point, :destination => inner_point }.merge!(get_distance(point, inner_point))
        end
      end
    end

    graph_array
  end

  private

  def get_distance(origin, destination)
    MapsApiCaller.new(origin, destination, nil, "super_secret_api_key").time_and_distance
  end
end