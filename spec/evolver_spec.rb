require "spec_helper"

describe Evolver do

  describe ".find" do

    let(:session) do
      Moped::Session.new([ "localhost:27017" ])
    end

    context "when the migration exists" do

      let(:found) do
        described_class.find("RenameBandsToArtists", session)
      end

      it "returns the migration instance" do
        found.file.should eq("20120519113509_rename_bands_to_artists.rb")
      end
    end

    context "when the migration does not exist" do

      it "raises an error" do
        expect {
          described_class.find("Test", session)
        }.to raise_error
      end
    end
  end

  describe ".load_migrations" do

    let(:path) do
      described_class.migrations_path
    end

    let(:files) do
      [ "migration.rb" ]
    end

    before do
      Dir.should_receive(:glob).with("#{path}/*.rb").and_return(files)
    end

    it "attempts to load the migrations in the directors" do
      expect {
        described_class.load_migrations
      }.to raise_error(
        LoadError,
        "cannot load such file -- #{path}/migration.rb"
      )
    end
  end

  describe ".migrations_path" do

    let(:path) do
      described_class.migrations_path
    end

    let(:expected) do
      File.expand_path(File.join(__FILE__, "..", "..", "db/evolver/migrations"))
    end

    it "returns the working directoy + /db/evolver/migrations" do
      path.should eq(expected)
    end
  end

  describe ".registry" do

    let(:registry) do
      described_class.registry
    end

    it "returns the registry hash" do
      registry["RenameBandsToArtists"].should_not be_empty
    end
  end

  describe ".register" do

    before do
      described_class.register("MoveSomeData", "test.rb", Time.now, [ :default ])
    end

    after do
      described_class.registry.delete("MoveSomeData")
    end

    it "adds the migration metadata to the registry" do
      described_class.registry["MoveSomeData"].should_not be_nil
    end
  end
end
