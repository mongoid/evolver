require "spec_helper"

describe Evolver::Loggable do

  describe "#logger=" do

    let(:klass) do
      Class.new do
        include Evolver::Loggable
      end.new
    end

    let(:logger) do
      Logger.new($stdout).tap do |log|
        log.level = Logger::INFO
      end
    end

    before do
      klass.logger = logger
    end

    it "sets the logger" do
      klass.logger.should eq(logger)
    end
  end
end
