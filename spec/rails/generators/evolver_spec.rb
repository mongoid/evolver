require "spec_helper"

describe Evolver::Generators::Base do

  describe ".next_migration_number" do

    let(:time) do
      Time.now
    end

    let(:expected) do
      Time.now.to_evolver_timestamp[0...12]
    end

    let(:timestamp) do
      described_class.next_migration_number("/path")
    end

    it "returns the timestamp as a string" do
      timestamp.should include(expected)
    end
  end
end
