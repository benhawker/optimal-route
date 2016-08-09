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

  # ----- #

  #Basic initial implementation - taking shortest each time. Most likely non-optimal.
  def basic
    #Assign origin as the start point - which we will amend at the end of each iteration.
    start_point = origin

    until optimal_route.size == points_to_visit.size + 1 #for the origin
      tmp = []

      #Get hold of the paths from the start point for this iteration and shovel them into tmp to analyse.
      graph.each do |path|
        tmp << path if path[:origin] == start_point
      end

      #Take the first possible path as the benchmark against which we can measure against.
      shortest = tmp.first

      tmp.each do |possible_path|
        shortest = possible_path if possible_path[:distance] < shortest[:distance]
      end

      #This is the shortest path from this start point so we use it.
      optimal_route << shortest

      #Delete nodes
      graph.delete_if { |h| h[:origin] == start_point }

      #Do not delete if the origin (also the endpoint) is the destination.
      graph.delete_if { |h| h[:destination] == start_point && h[:destination] != origin }

      #Assign the destination of the current path as the new start point for the next iteration.
      start_point = shortest[:destination]
    end
    optimal_route
  end

  # ----- #

  #Better solution, but longer processing time and still not guaranteed to be optimal.
  def random(number_of_iterations=50)
    solutions = []

     number_of_iterations.times do
      solutions << generate_route
    end

    find_optimal_route(solutions)
  end

  def generate_route
    start_point = origin
    route = []
    visited = []

    (points_to_visit.size + 1).times do
      paths_to_explore = []

      #Get hold of the paths from the start point for this iteration and shovel them into paths_to_explore to analyse.
      graph.each do |path|
        # Don't revisit any points
        if path[:origin] == start_point
          paths_to_explore << path
        end
      end

      puts "------- Paths to explore before deletion -------"
      puts paths_to_explore

      #Remove paths that take us back to the origin unless all points are visited.
      #We then delete the origin from visited otherwise possible paths will be deleted in the below condition (visited.include?)
      unless route.size == points_to_visit.size
        paths_to_explore.delete_if {|path| origin == path[:destination] }
        visited.delete(origin)
      end

      #Remove paths that we have already visited
      paths_to_explore.delete_if {|path| visited.include?(path[:destination]) }

      puts "------- Paths to explore after deletion -------"
      puts paths_to_explore

      #Select a path at random. We will be generating many routes so we randomly build lots of ways through the path.
      path = paths_to_explore.sample

      puts "------- Selected -------"
      puts path

      #Don't delete anythign from the graph but we need to track where we have visited.
      visited << path[:origin]

      puts "------- Visited -------"
      puts visited

      # Assign the destination of the current path as the new start point for the next iteration.
      start_point = path[:destination]

      #Shovel this path into the route we are generating
      route << path

      puts "------- Route -------"
      puts route
    end
    route
  end

  def find_optimal_route(solutions)
    distances = []

     #Iterate through the solutions, calculate the distances & return the best result.
    solutions.each_with_index do |solution|
      distances << calculate_distance(solution)
    end

    shortest_distance = distances.min

    shortest_path = solutions[(distances.index(shortest_distance))]
    shortest_path_string = shortest_path.map { |h| h[:origin] }.join(" => ") + " => " +  origin

    puts "Shortest path calculated is #{shortest_distance} via #{shortest_path_string}"
  end

  def calculate_distance(solution)
    solution.map { |h| h[:distance] }.inject(:+)
  end

  # ----- #

end

#graph = [{:origin=>"Windsor Castle, Windsor, UK", :destination=>"Buckingham Palace, London, UK", :distance=>34593, :duration=>25596}, {:origin=>"Windsor Castle, Windsor, UK", :destination=>"Trafalgar Square, London, UK", :distance=>35675, :duration=>26440}, {:origin=>"Windsor Castle, Windsor, UK", :destination=>"The Oval, London, UK", :distance=>41067, :duration=>30537}, {:origin=>"Buckingham Palace, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>34603, :duration=>25755}, {:origin=>"Trafalgar Square, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>35676, :duration=>26530}, {:origin=>"The Oval, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>41067, :duration=>30632}, {:origin=>"Buckingham Palace, London, UK", :destination=>"Trafalgar Square, London, UK", :distance=>1386, :duration=>1061}, {:origin=>"Buckingham Palace, London, UK", :destination=>"The Oval, London, UK", :distance=>7411, :duration=>5637}, {:origin=>"Trafalgar Square, London, UK", :destination=>"Buckingham Palace, London, UK", :distance=>1386, :duration=>1011}, {:origin=>"Trafalgar Square, London, UK", :destination=>"The Oval, London, UK", :distance=>6137, :duration=>4641}, {:origin=>"The Oval, London, UK", :destination=>"Buckingham Palace, London, UK", :distance=>7411, :duration=>5587}, {:origin=>"The Oval, London, UK", :destination=>"Trafalgar Square, London, UK", :distance=>6137, :duration=>4632}]


