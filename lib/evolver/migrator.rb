# encoding: utf-8
require "evolver/migration"

module Evolver
  class Migrator

    attr_reader :sessions

    def execute
      # For each session in the configuration, find the migrations that need to
      # be run for each.
      #
      # Iterate through each of the sessions, executing their pending migrations
      # in order.
      sessions.each do |session|
        pending_migrations(session).each do |migration|
          migration.execute
          migration.mark_as_executed
        end
      end
    end

    def initialize(sessions)
      @sessions = sessions
    end

    def pending_migrations(session)
      executed = executed_migrations(session)
      Evolver.registry.reduce([]) do |pending, (klass, metadata)|
        unless executed.include?(klass)
          file, time = metadata[:file], metadata[:time]
          pending.push(Object.const_get(klass).new(file, session, time))
        end
        pending
      end
    end

    def revert

      # For each session in the configuration, find the last migration that was
      # run.
      #
      # Iterate through each of the sessions, reverting the migrations in
      # reverse.
    end

    def executed_migrations(session)
      session[:evolver_migrations].find.select(_id: 0, migration: 1).entries
    end
  end
end
