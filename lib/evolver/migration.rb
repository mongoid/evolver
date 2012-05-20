# encoding: utf-8
require "active_support/concern"

module Evolver
  module Migration
    extend ActiveSupport::Concern

    attr_reader :file, :session, :time

    # Instantiate the migration.
    #
    # @example Instantiate the migration.
    #   Migration.new(file, session, time)
    #
    # @param [ String ] file The name of the file.
    # @param [ Moped::Session ] session The session to run on.
    # @param [ Time ] time The generation time.
    #
    # @since 0.0.0
    def initialize(file, session, time)
      @file, @session, @time = file, session, time
    end

    # Mark the migration as having been executed. This inserts a new document
    # into the evolver_migrations collection in the session's database.
    #
    # @return [ nil ] nil.
    #
    # @since 0.0.0
    def mark_as_executed
      session[:evolver_migrations].insert({
        file: file,
        generated: time,
        migration: self.class.name,
        executed: Time.now
      })
    end

    module ClassMethods

      # Get the name of the migration file, based on the call stack.
      #
      # @example Get the name of the file.
      #   Migration.file(caller[0])
      #
      # @param [ String ] stack The last caller in the stack.
      #
      # @return [ String ] The name of the migration file.
      #
      # @since 0.0.0
      def file(stack)
        File.basename(stack).split(":")[0]
      end

      # Define which sessions the migration will run on.
      #
      # @example Define the sessions to run on.
      #   Migration.sessions(:default, :secondary)
      #
      # @param [ Array<Symbol> ] names The session names.
      #
      # @return [ Hash ] The metadata in the registry.
      #
      # @since 0.0.0
      def sessions(*names)
        Evolver.register(self.name, file(caller[0]), time(caller[0]), names)
      end

      # Get the generation time of the migration.
      #
      # @example Get the generation time.
      #   Migration.time(stack)
      #
      # @param [ String ] stack The last caller in the stack.
      #
      # @return [ Time ] The time the migration was generated.
      #
      # @since 0.0.0
      def time(stack)
        ::Time.from_evolver_timestamp(file(stack)[0...14])
      end
    end
  end
end
