# encoding: utf-8
module Evolver
  module Extensions
    module Time

      def evolver_timestamp
        strftime("%Y%m%d%H%M%S")
      end
    end
  end
end

::Time.__send__(:include, Evolver::Extensions::Time)
