require "spec_helper"

describe Evolver do

  describe ".find" do

    let(:session) do
      Mongoid.default_session
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
      }.to raise_error(LoadError)
    end
  end

  describe ".migrate", config: :mongohq do

    let(:default) do
      Mongoid.default_session
    end

    let(:mongohq) do
      Mongoid.session(:mongohq_repl)
    end

    context "when no migrations have been run" do

      before(:all) do
        default[:labels].insert({ bands: [ "Placebo", "Depeche Mode" ]})
        mongohq[:labels].insert({ bands: [ "Placebo", "Depeche Mode" ]})
      end

      after(:all) do
        default[:labels].find.remove_all
        default[:evolver_migrations].find.remove_all
        mongohq[:labels].find.remove_all
        mongohq[:evolver_migrations].find.remove_all
        default.use(:evolver_secondary)
        default[:labels].find.remove_all
        default[:evolver_migrations].find.remove_all
        default.use(:evolver_test)
      end

      context "when migrating on a mix of sessions" do

        before(:all) do
          described_class.migrate
        end

        let(:default_label) do
          default[:labels].find.one
        end

        let(:mongohq_label) do
          mongohq[:labels].find.one
        end

        let(:default_migrations) do
          default[:evolver_migrations]
        end

        let(:mongohq_migrations) do
          mongohq[:evolver_migrations]
        end

        it "runs the first migration on the default session" do
          default_label["artists"].should eq([ "Placebo", "Depeche Mode" ])
        end

        it "flags the first migration as run on the default session" do
          default_migrations.find(
            migration: "RenameBandsToArtists", executed: { "$exists" => true }
          ).count.should eq(1)
        end

        it "does not run the first migration on the mongohq session" do
          mongohq_label["artists"].should be_nil
        end

        it "does not flag the first migration as run on the mongohq session" do
          mongohq_migrations.find(
            migration: "RenameBandsToArtists", executed: { "$exists" => true }
          ).count.should eq(0)
        end

        it "runs the second migration on the default session" do
          default_label["likes"].should eq(0)
        end

        it "flags the second migration as run on the default session" do
          default_migrations.find(
            migration: "AddLikesToLabel", executed: { "$exists" => true }
          ).count.should eq(1)
        end

        it "runs the second migration on the mongohq session" do
          mongohq_label["likes"].should eq(0)
        end

        it "flags the second migration as run on the mongohq session" do
          mongohq_migrations.find(
            migration: "AddLikesToLabel", executed: { "$exists" => true }
          ).count.should eq(1)
        end

        it "runs the third migration on the mongohq session" do
          mongohq_label["impressions"].should eq(0)
        end

        it "flags the third migration as run on the mongohq session" do
          mongohq_migrations.find(
            migration: "AddImpressionsToLabel", executed: { "$exists" => true }
          ).count.should eq(1)
        end

        it "does not run the third migration on the default session" do
          default_label["impressions"].should be_nil
        end

        it "does not flag the third migration as run on the default session" do
          default_migrations.find(
            migration: "AddImpressionsToLabel", executed: { "$exists" => true }
          ).count.should eq(0)
        end

        it "runs the migrations on the secondary database" do
          default.use(:evolver_secondary)
          default[:labels].find.one["bands"].should eq([ "Tool" ])
        end

        it "stores migration information for secondary database in default" do
          default.use(:evolver_test)
          default[:evolver_migrations].find(
            migration: "CopyLabelsToSecondary", executed: { "$exists" => true }
          ).count.should eq(0)
        end
      end
    end
  end

  describe ".migrations_path" do

    let(:path) do
      described_class.migrations_path
    end

    let(:expected) do
      File.expand_path(File.join(__FILE__, "..", "db/evolver/migrations"))
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
