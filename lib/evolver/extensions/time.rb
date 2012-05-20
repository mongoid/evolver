# encoding: utf-8
require "time"

module Evolver
  module Extensions
    module Time

      FORMAT = "%Y%m%d%H%M%S"

      def to_evolver_timestamp
        strftime(FORMAT)
      end

      module ClassMethods

        def from_evolver_timestamp(timestamp)
          ::Time.strptime(timestamp, FORMAT)
        end
      end
    end
  end
end

::Time.__send__(:include, Evolver::Extensions::Time)
::Time.__send__(:extend, Evolver::Extensions::Time::ClassMethods)
