# encoding: utf-8
require "evolver/migration"

module Evolver
  module Migrator

    attr_reader :sessions

    def initialize(sessions)
      # @sessions = sessions
    end

    def execute
      # For each session in the configuration, find the migrations that need to
      # be run for each.
      #
      # Iterate through each of the sessions, executing their pending migrations
      # in order.
      # sessions.each do |session|
        # Get the pending migrations for this session.
        # pending_migrations(session).each do |migration|
          # Execute the migration.
          # migration.execute
          # Update the database to say this migration has been executed.
          # migration.mark_as_executed
        # end
      # end
    end

    def revert

      # For each session in the configuration, find the last migration that was
      # run.
      #
      # Iterate through each of the sessions, reverting the migrations in
      # reverse.
    end
  end
end
