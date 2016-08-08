# +OptimalRouteFinder+ - receives the GMaps parsed responses to then calculate the optimal routing.
#
# Proposed usage:
# => route_finder = OptimalRouteFinder.new(xxx)
# => route_finder.calculate

class OptimalRouteFinder
  attr_reader :graph, :optimal_route, :origin, :points_to_visit

  def initialize(origin, points_to_visit=[])
    @origin = origin
    @points_to_visit = points_to_visit
    @graph = GraphBuilder.new(origin, points_to_visit).get_distances
    @optimal_route = []
  end

  def calculate
    start_point = origin

    graph.each do |record|
      tmp = []

      if record[:origin] == start_point
        tmp << record
      end
    end

    # tmp.each do |record|
    #   record[:distance].min
    # end

  end
end