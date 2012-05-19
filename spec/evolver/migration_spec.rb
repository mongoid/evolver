require "spec_helper"

describe Evolver::Migration do

  describe ".sessions" do

    after do
      Evolver.registry.clear
    end

    context "when provided a single session" do

      before do
        require "db/evolutions/20120519113509-rename_bands_to_artists"
      end

      after do
        Object.__send__(:remove_const, :RenameBandsToArtists)
      end

      let(:registry) do
        Evolver.registry.fetch(RenameBandsToArtists)
      end

      it "adds the migration to the session" do
        registry.should eq({
          file: "20120519113509-rename_bands_to_artists.rb",
          timestamp: "20120519113509",
          sessions: [ :default ]
        })
      end
    end
  end
end
