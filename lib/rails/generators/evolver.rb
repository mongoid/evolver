# encoding: utf-8
require "rails/generators/migration"
require "rails/generators/named_base"

module Evolver
  module Generators
    class Base < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      class << self

        def next_migration_number(dirname)
          Time.now.to_evolver_timestamp
        end
      end
    end
  end
end
