# encoding: utf-8
module Evolver
  class Railtie < Rails::Railtie
    rake_tasks do
      load "evolver/tasks/db.rake"
    end
  end
end
