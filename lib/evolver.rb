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
  def register(migration, file, time, sessions)
    registry.store(migration, { file: file, time: time, sessions: sessions })
  end
end
