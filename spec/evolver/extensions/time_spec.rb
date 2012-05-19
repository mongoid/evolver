require "spec_helper"

describe Evolver::Extensions::Time do

  describe "#evolver_timestamp" do

    let(:time) do
      Time.new(2012, 1, 5, 12, 45, 30)
    end

    let(:stamp) do
      time.evolver_timestamp
    end

    it "returns the timestamp in YYYYMMDDHHMMSS format" do
      stamp.should eq("20120105124530")
    end
  end
end
