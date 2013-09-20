require "spec_helper"

describe Evolver::Migrator do

  let(:session) do
    Mongoid.default_session
  end

  before do
    session[:evolver_migrations].find.remove_all
  end

  describe "#execute" do

    context "dry run" do

      let(:migrator) do
        described_class.new({ default: session }, { dry: true })
      end

      before { migrator.execute }

      let(:migrations) do
        session[:evolver_migrations].find.sort(generated: 1).to_a
      end

      it "does not execute the migrations" do
        migrations.count.should eq(0)
      end
    end

    context "when no migrations have been run" do

      let(:migrator) do
        described_class.new({ default: session })
      end

      before do
        session[:labels].insert({
          bands: [ "Depeche Mode", "Erasure" ],
          founded: Time.new(1980, 1, 1),
          name: "Mute UK"
        })
        migrator.execute
      end

      after do
        session[:labels].find.remove_all
      end

      let(:migrations) do
        session[:evolver_migrations].find.sort(generated: 1).to_a
      end

      it "runs all the migrations" do
        migrations.count.should eq(2)
      end

      it "sets the first migration as executed" do
        migrations.first["executed"].should be_within(1).of(Time.now)
      end

      it "sets the last migration as executed" do
        migrations.first["executed"].should be_within(1).of(Time.now)
      end

      it "executes the first migration" do
        session[:labels].find.first["artists"].should eq(
          [ "Depeche Mode", "Erasure" ]
        )
      end

      it "executes the second migration" do
        session[:labels].find.first["likes"].should eq(0)
      end
    end
  end

  describe "#initialize" do

    let(:session) do
      Mongoid.default_session
    end

    let(:migrator) do
      described_class.new(default: session)
    end

    it "sets the sessions" do
      migrator.sessions.should eq(default: session)
    end
  end
end
