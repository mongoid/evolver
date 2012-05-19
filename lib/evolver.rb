# encoding: utf-8
require "moped"
require "evolver/migrator"
require "evolver/version"

module Evolver
  extend self

  def run
    # Migrator.new(sessions).execute
  end

  # Register a migration as running for the provided sessions.
  def register(migration, sessions)
  end
end
