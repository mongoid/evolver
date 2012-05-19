# encoding: utf-8
module Evolver
  module Migration

    attr_reader :session

    # Inject the session that this migration will use.
    def initialize(session)
      # @session = session
    end

    def mark_as_executed
    end

    class << self

      def sessions(*names)
        # Register the sessions that will be used with this migration.
      end
    end
  end
end
