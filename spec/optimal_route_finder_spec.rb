require "spec_helper"

RSpec.describe OptimalRouteFinder do
  let(:origin) { "Windsor Castle, Windsor, UK" }
  let(:points_to_visit) { ["Buckingham Palace, London, UK", "Trafalgar Square, London, UK", "The Oval, London, UK"] }
  subject { described_class.new(origin, points_to_visit) }

  describe "#caculate" do
    it "returns the optimal path" do
      expect(subject.calculate).to eq "something"
    end
  end
end


# response = {

#               ["Windsor Castle, Windsor, UK", "Buckingham Palace, London, UK"] => {:distance => 10, :duration => 10},
#               ["Windsor Castle, Windsor, UK", "Trafalgar Square, London, UK"] => {:distance => 10, :duration => 10},
#               ["Windsor Castle, Windsor, UK", "The Oval, London, UK"] => {:distance => 10, :duration => 10},
#               ["Buckingham Palace, London, UK", "Trafalgar Square, London, UK"] => {:distance => 10, :duration => 10},
#               ["Buckingham Palace, London, UK", "The Oval, London, UK"] => {:distance => 10, :duration => 10},
#               ["Trafalgar Square, London, UK", "Buckingham Palace, London, UK"] => {:distance => 10, :duration => 10},
#               ["Trafalgar Square, London, UK", "The Oval, London, UK"] => {:distance => 10, :duration => 10},
#               ["The Oval, London, UK", "Buckingham Palace, London, UK"] => {:distance => 10, :duration => 10},
#               ["The Oval, London, UK", "Trafalgar Square, London, UK"] => {:distance => 10, :duration => 10}
#             }
