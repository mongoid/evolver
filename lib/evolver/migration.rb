# encoding: utf-8
require "active_support/concern"

module Evolver
  module Migration
    extend ActiveSupport::Concern

    attr_reader :session

    # Inject the session that this migration will use.
    def initialize(session)
      # @session = session
    end

    def mark_as_executed
    end

    module ClassMethods

      def file(stack)
        File.basename(stack).split(":")[0]
      end

      def sessions(*names)
        Evolver.register(self, file(caller[0]), timestamp(caller[0]), names)
      end

      def timestamp(stack)
        file(stack).split("-")[0]
      end
    end
  end
end
