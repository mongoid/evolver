# encoding: utf-8
require "rails/generators/evolver"

module Evolver
  module Generators
    class MigrationGenerator < Base

      source_root File.join(File.dirname(__FILE__), "templates")

      def create_migration_file
        migration_template "migration.rb", "db/evolver/migrations/#{file_name}.rb"
      end
    end
  end
end
