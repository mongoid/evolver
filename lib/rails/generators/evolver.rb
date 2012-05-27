# encoding: utf-8
require "rails/generators"
require "rails/generators/migration"
require "rails/generators/named_base"

module Evolver
  module Generators
    class Base < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      class << self

        # Get the next migration number, ignoring the directory name and simply
        # going off the timestamp.
        #
        # @example Get the next migration number.
        #   Base.next_migration_number(dir)
        #
        # @param [ String ] dirname The directory name. (Ignored)
        #
        # @return [ String ] The timestamp.
        #
        # @since 0.0.0
        def next_migration_number(dirname)
          Time.now.to_evolver_timestamp
        end
      end
    end
  end
end
