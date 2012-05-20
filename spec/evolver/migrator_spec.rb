require "spec_helper"

describe Evolver::Migrator do

  describe "#initialize" do

    let(:session) do
      Moped::Session.new([ "localhost:27017" ])
    end

    let(:migrator) do
      described_class.new([ session ])
    end

    it "sets the sessions" do
      migrator.sessions.should eq([ session ])
    end
  end
end
