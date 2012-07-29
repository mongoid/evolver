# encoding: utf-8
require "evolver/loggable"
require "evolver/migration"

module Evolver
  class Migrator
    include Loggable

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
      sessions.each_pair do |name, session|
        pending(name, session.with(safe: true, consistency: :strong)) do |migration|
          migration.execute
          log_execution(migration, name)
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
    #   migrator.pending(session)
    #
    # @param [ Symbol ] name The name of the session.
    # @param [ Moped::Session ] session The session to use.
    #
    # @return [ Array<Migration> ] The migrations that need to run.
    #
    # @since 0.0.0
    def pending(name, session)
      run = executed_migrations(session)
      Evolver.registry.keys.reduce([]) do |pending, klass|
        pending.push(Evolver.find(klass, session)) if runnable?(run, klass, name)
        pending
      end.each do |migration|
        yield(migration)
      end
    end

    private

    # Log a message.
    #
    # @api private
    #
    # @example Log a message.
    #   migrator.log(:success, "it worked.")
    #
    # @param [ Symbol ] type The type of message.
    # @param [ Sting ] message The message.
    #
    # @since 0.0.0
    def log(type, message)
      logger.info("  EVOLVER: #{type.upcase} #{message}")
    end

    # Log an execution message.
    #
    # @api private
    #
    # @example Log an execution message.
    #   migrator.log_execution(Migration, :default)
    #
    # @param [ Migration ] migration The migration.
    # @param [ Symbol ] name The session name.
    #
    # @since 0.0.0
    def log_execution(migration, name)
      log(:success, "#{migration.class.name} on session #{name.inspect}")
    end

    # Can the migration be run now, and in the session?
    #
    # @api private
    #
    # @example Is the migration runnable?
    #   migrator.runnable?(run, klass, name)
    #
    # @param [ Array<Migration> ] run The current migration run.
    # @param [ Class ] klass The Migration class.
    # @param [ Symbol, String ] The session key.
    #
    # @return [ true, false ] If the migration is runnable.
    #
    # @since 0.0.0
    def runnable?(run, klass, name)
      metadata = Evolver.registry.fetch(klass)
      !run.include?(klass) && metadata[:sessions].include?(name)
    end
  end
end
