# +MapsResponseInfoGetter+
#
# Usage:
# => getter = ResponseInfoGetter.new(parsed_api_response)
# => getter.return

class ResponseInfoGetter
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def return
    {
      distance: distance_in_meters,
      duration: duration_in_seconds
    }
  end

  private

  def distance_in_meters
    response["routes"][0]["legs"][0]["distance"]["value"]
  end

  def duration_in_seconds
    response["routes"][0]["legs"][0]["duration"]["value"]
  end
end