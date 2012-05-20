# encoding: utf-8
require "active_support/concern"

module Evolver
  module Migration
    extend ActiveSupport::Concern

    attr_reader :file, :session, :time

    def initialize(file, session, time)
      @file, @session, @time = file, session, time
    end

    def mark_as_executed
    end

    module ClassMethods

      def file(stack)
        File.basename(stack).split(":")[0]
      end

      def sessions(*names)
        Evolver.register(self, file(caller[0]), time(caller[0]), names)
      end

      def time(stack)
        ::Time.from_evolver_timestamp(file(stack).split("-")[0])
      end
    end
  end
end
