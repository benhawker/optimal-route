require "spec_helper"

RSpec.describe PointsToVisit do
  let(:origin) { "Windsor Castle, Windsor, UK" }
  let(:points_to_visit) { ["Buckingham Palace, London, UK", "Trafalgar Square, London, UK"] }
  subject { described_class.new(origin, points_to_visit) }

  describe "#initialize" do
    before { allow(described_class).to receive(:new).and_raise("Your location: dbfbfb is not recognised by Google Maps.") }

    it "raises an error if any of locations are not recognised by the GMaps Api" do
      message = "Your location: dbfbfb is not recognised by Google Maps."
      expect { described_class.new(origin, ["dbfbfb"]) }.to raise_error(message)
    end
  end

  describe "#response" do
    it "returns a hash" do
      response = {:origin=>"Windsor Castle, Windsor, UK", :points_to_visit=>["Buckingham Palace, London, UK", "Trafalgar Square, London, UK"]}
      expect(subject.response).to eq response
    end
  end
end