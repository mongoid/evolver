# encoding: utf-8
require "time"

module Evolver
  module Extensions
    module Time

      FORMAT = "%Y%m%d%H%M%S"

      # Convert the time to a migration friendly time that will be prefixed in
      # the file name.
      #
      # @example Generate the timestamp.
      #   time.to_evolver_timestamp
      #
      # @return [ String ] The time prefix for the file name.
      #
      # @since 0.0.0
      def to_evolver_timestamp
        strftime(FORMAT)
      end

      module ClassMethods

        # Instantiate a time object based on the timestamp string that is used
        # as a file name prefix.
        #
        # @example Generate the time from the timestamp string.
        #   Time.from_evolver_timestamp("20120101120000")
        #
        # @param [ String ] timestamp The file prefix timestamp.
        #
        # @return [ Time ] The time for the timestamp.
        #
        # @since 0.0.0
        def from_evolver_timestamp(timestamp)
          ::Time.strptime(timestamp, FORMAT)
        end
      end
    end
  end
end

::Time.__send__(:include, Evolver::Extensions::Time)
::Time.__send__(:extend, Evolver::Extensions::Time::ClassMethods)
