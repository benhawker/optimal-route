require "spec_helper"

RSpec.describe GraphBuilder do

  let(:origin) { "Windsor Castle, Windsor, UK" }
  let(:points_to_visit) { ["Buckingham Palace, London, UK", "Trafalgar Square, London, UK", "The Oval, London, UK"] }
  subject { described_class.new(origin, points_to_visit) }

  describe "#get_distance_from_origin_to_other_points" do

    before do
      allow(subject).to receive(:get_distance) do |origin, destination|
        if origin == "Windsor Castle, Windsor, UK" && destination == "Buckingham Palace, London, UK"
          {:distance=> 34593, :duration=>25596}
        elsif origin == "Windsor Castle, Windsor, UK" && destination == "Trafalgar Square, London, UK"
          {:distance=> 35675, :duration=>26440}
        elsif origin == "Windsor Castle, Windsor, UK" && destination == "The Oval, London, UK"
          {:distance=>41067, :duration=>30537}
        end
      end
    end

    it "returns a hash with the correct distances between all locations" do
      response = [
                    {:origin=>"Windsor Castle, Windsor, UK", :destination=>"Buckingham Palace, London, UK", :distance=>34593, :duration=>25596},
                    {:origin=>"Windsor Castle, Windsor, UK", :destination=>"Trafalgar Square, London, UK", :distance=>35675, :duration=>26440},
                    {:origin=>"Windsor Castle, Windsor, UK", :destination=>"The Oval, London, UK", :distance=>41067, :duration=>30537}
                  ]

      expect(subject.get_distance_from_origin_to_other_points).to eq response
    end
  end

  describe "#get_distances" do

    before do
      allow_any_instance_of(described_class).to receive(:get_distance).and_return( {:distance => 10, :duration => 1} )
    end

    it "returns a hash with the correct distances between all locations" do
      response = [
                    {:origin=>"Windsor Castle, Windsor, UK", :destination=>"Buckingham Palace, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"Windsor Castle, Windsor, UK", :destination=>"Trafalgar Square, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"Windsor Castle, Windsor, UK", :destination=>"The Oval, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"Buckingham Palace, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>10, :duration=>1},
                    {:origin=>"Trafalgar Square, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>10, :duration=>1},
                    {:origin=>"The Oval, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>10, :duration=>1},
                    {:origin=>"Buckingham Palace, London, UK", :destination=>"Trafalgar Square, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"Buckingham Palace, London, UK", :destination=>"The Oval, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"Trafalgar Square, London, UK", :destination=>"Buckingham Palace, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"Trafalgar Square, London, UK", :destination=>"The Oval, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"The Oval, London, UK", :destination=>"Buckingham Palace, London, UK", :distance=>10, :duration=>1},
                    {:origin=>"The Oval, London, UK", :destination=>"Trafalgar Square, London, UK", :distance=>10, :duration=>1}
                  ]

      expect(subject.get_distances).to eq response
    end
  end
end