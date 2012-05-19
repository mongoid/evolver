require "spec_helper"

describe Evolver do

  describe ".session" do

    context "when no configuration is found" do

      it "raises an error" do

      end
    end

    context "when a config/evolver.yml is found" do

      it "returns the default session" do

      end
    end

    context "when a config/mongoid.yml is found" do

      it "returns the default session" do

      end
    end
  end

  describe ".sessions" do

    context "when providing no name" do

      it "raises an error" do

      end
    end

    context "when providing a name" do

      context "when the configuration exists" do

        it "returns the named session" do

        end
      end

      context "when the configuration does not exist" do

        it "raises an error" do

        end
      end
    end
  end
end
