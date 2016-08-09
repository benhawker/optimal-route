require "spec_helper"

RSpec.describe OptimalRouteFinder do
  let(:origin) { "Windsor Castle, Windsor, UK" }
  let(:points_to_visit) { ["Buckingham Palace, London, UK", "Trafalgar Square, London, UK", "The Oval, London, UK"] }
  subject { described_class.new(origin, points_to_visit) }

  describe "#basic" do
    it "calculates a path correctly" do
      expect(subject.basic).to eq [{:origin=>"Windsor Castle, Windsor, UK", :destination=>"Buckingham Palace, London, UK", :distance=>34593, :duration=>25596}, {:origin=>"Buckingham Palace, London, UK", :destination=>"Trafalgar Square, London, UK", :distance=>1386, :duration=>1061}, {:origin=>"Trafalgar Square, London, UK", :destination=>"The Oval, London, UK", :distance=>6137, :duration=>4641}, {:origin=>"The Oval, London, UK", :destination=>"Windsor Castle, Windsor, UK", :distance=>41067, :duration=>30632}]
    end
  end

  describe "#random" do
    it "calculates a path correctly" do
      expect(subject.random).to eq  "Windsor Castle, Windsor, UK => Buckingham Palace, London, UK => Trafalgar Square, London, UK => The Oval, London, UK => Windsor Castle, Windsor, UK"
    end
  end
end
