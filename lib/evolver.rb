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

  def migrate
    # load_migrations
    # Migrator.new(sessions).execute
  end

  # Load all the migrations in the application.
  #
  # @example Load all the migrations.
  #   Evolver.load_migrations
  #
  # @return [ Array<String> ] The migration filenames.
  #
  # @since 0.0.0
  def load_migrations
    Dir.glob("#{migrations_path}/*.rb").each do |filename|
      load_migration(filename)
    end
  end

  # Load the migration for the provided filename.
  #
  # @example Load the migration.
  #   Evolver.load_migration("20120101120000_move_data.rb")
  #
  # @param [ String ] filename The name of the migration file.
  #
  # @return [ true, false ] If the require succeeded.
  #
  # @since 0.0.0
  def load_migration(filename)
    require("#{migrations_path}/#{filename}")
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
    # load_migration(last_run)
  end

  def stats
    # load_migrations
  end
end
