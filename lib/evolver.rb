# encoding: utf-8
require "moped"
require "evolver/extensions"
require "evolver/migrator"
require "evolver/railtie" if defined?(Rails)
require "evolver/version"

module Evolver
  extend self

  # Get an instance of the migration class from the registry with the provided
  # session.
  #
  # @example Get the migration.
  #   Evolver.find("MoveSomeData", session)
  #
  # @param [ String ] migration The name of the migration class.
  # @param [ Moped::Session ] session The current session.
  #
  # @return [ Migration ] The instantiated migration.
  #
  # @since 0.0.0
  def find(migration, session)
    metadata = registry.fetch(migration)
    Object.const_get(migration).new(metadata[:file], session, metadata[:time])
  end

  def generate
    # Delegate to the rails generator?
  end

  def migrate
    # Should be require all the migrations here? Methinks so.
    # Dir.pwd /db/evolver/migrations/
  end

  # Get the path where evolver's migrations are stored. This is
  # db/evolver/migrations from the root of whatever framework you are using or
  # the root of your standalone project.
  #
  # @example Get the migrations path.
  #   Evolver.migrations_path
  #
  # @return [ String ] "/path/to/my/app/db/evolver/migrations"
  #
  # @since 0.0.0
  def migrations_path
    File.join(Dir.pwd, "db/evolver/migrations")
  end

  # Get evolver's registry of migration metadata.
  #
  # @example Get the registry.
  #   Evolver.registry
  #
  # @return [ Hash ] The metadata registry.
  #
  # @since 0.0.0
  def registry
    @registry ||= {}
  end

  # Register a migration's metadata with the evolver.
  #
  # @example Register the migration.
  #   Evolver.register(MoveSomeData, "move_some_data.rb", time, sessions)
  #
  # @param [ Class ] migration The migration class.
  # @param [ String ] file The file name of the migration.
  # @param [ Time ] time The generation time of the migration.
  # @param [ Array<Symbol> ] sessions The names of the sessions this applies
  #   to.
  #
  # @return [ Hash ] The migration metadata.
  #
  # @since 0.0.0
  def register(migration, file, time, sessions)
    registry.store(migration, { file: file, time: time, sessions: sessions })
  end

  def revert
    # We only need to require the last migration run.
  end

  def stats
    # Require all the migrations.
  end
end
