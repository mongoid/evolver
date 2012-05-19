# encoding: utf-8
require "moped"
require "evolver/extensions"
require "evolver/migrator"
require "evolver/version"

module Evolver
  extend self

  def run
    # Migrator.new(sessions).execute
  end

  def registry
    @registry ||= {}
  end

  # Register a migration as running for the provided sessions.
  def register(migration, file, timestamp, sessions)
    registry.store(
      migration, { file: file, timestamp: timestamp, sessions: sessions }
    )
  end
end
