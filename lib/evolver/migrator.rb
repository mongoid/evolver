# encoding: utf-8
require "evolver/migration"

module Evolver
  class Migrator

    attr_reader :sessions

    # Execute the migrations. This grabs all pending migrations in order and
    # calls execute on them for each session that it has specified it runs on.
    # Once the migration has finished without errors, a migrations document
    # gets inserted into the "evolver_migrations" collection in that session.
    #
    # @example Execute the migrations.
    #   migrator.execute
    #
    # @return [ Array<Moped::Session> ] The sessions that were used.
    #
    # @since 0.0.0
    def execute
      sessions.each do |session|
        pending_migrations(session).each do |migration|
          migration.execute
          migration.mark_as_executed
        end
      end
    end

    # Get a list of the class names of all the migrations that have already
    # been run. This is so we can determine what not to run.
    #
    # @example Get the already executed migrations for a session.
    #   migrator.executed_migrations(session)
    #
    # @param [ Moped::Session ] session The session to use.
    #
    # @return [ Array<String> ] The class names of the run migrations.
    #
    # @since 0.0.0
    def executed_migrations(session)
      session[:evolver_migrations].find.select(_id: 0, migration: 1).entries
    end

    # Instantiate the new migrator. This object handles the migration runs.
    #
    # @example Instantiate the migrator.
    #   Migrator.new([ session ])
    #
    # @param [ Array<Moped::Session> ] sessions The sessions to migrate on.
    #
    # @since 0.0.0
    def initialize(sessions)
      @sessions = sessions
    end

    # Get the list of pending migrations - those that need to be executed
    # during this run.
    #
    # @example Get the pending migrations.
    #   migrator.pending_migrations(session)
    #
    # @param [ Moped::Session ] session The session to use.
    #
    # @return [ Array<Migration> ] The migrations that need to run.
    #
    # @since 0.0.0
    def pending_migrations(session)
      executed = executed_migrations(session)
      Evolver.registry.reduce([]) do |pending, (klass, meta)|
        unless executed.include?(klass)
          pending.push(Object.const_get(klass).new(meta[:file], session, meta[:time]))
        end
        pending
      end
    end
  end
end
