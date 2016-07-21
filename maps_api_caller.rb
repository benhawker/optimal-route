# +MapsApiCaller+ - calls the Google Maps Directions API and returns a parsed response.
# The MapsResponseInfoGetter class will then deal with pulling the relevant info from the parsed response.
#
# Proposed usage:
# => caller = MapsApiCaller.new('Brooklyn', 'Queens', 'walking', 'your_token')
# => caller.call

require 'httparty'
require 'json'

class MapsApiCaller
  include HTTParty

  # Error that is raised when an invalid mode of transport is specified
  class InvalidTravelMode < StandardError
    def initialize(mode)
      super("Your mode: '#{mode}'' is not valid. Try one of these #{VALID_MODES}")
    end
  end

  BASE_URL = "https://maps.googleapis.com/maps/api/directions/json"
  VALID_MODES = %w(driving walking bicycling transit)
  DEFAULT_MODE = "walking"
  # Example request: "https://maps.googleapis.com/maps/api/directions/json?origin=Brooklyn&destination=Queens&mode=walking&key=YOUR_KEY"

  attr_reader :base_url, :origin, :destination, :mode, :key

  def initialize(origin, destination, mode=DEFAULT_MODE, key)
    @base_url = BASE_URL
    @origin = origin
    @destination = destination
    @mode = mode
    @key = key

    raise InvalidTravelMode.new(mode) unless valid_mode?(mode)
  end

  def call
    response = HTTParty.get(
        "#{base_url}?#{build_params}",
         verify: false, headers: { "Content-Type" => "application/json" }
      )

      prepare_response(response)
  end

  private

  def build_params
    params = {
                :origin      => origin,
                :destination => destination,
                :mode        => mode,
                :key         => key
              }

    transform_params!(params)
  end

  # Transforms {:a => 2, :b => 2} to "a=2&b=2"
  def transform_params!(params)
    URI.encode_www_form(params)
  end

  def prepare_response(response)
    JSON.parse(response.body)
  end

  def valid_mode?(mode)
    VALID_MODES.include?(mode)
  end
end