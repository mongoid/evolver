# encoding: utf-8
require "rails/railtie"

module Evolver
  class Railtie < Rails::Railtie

    # Expose evolver's rake tasks to Rails.
    rake_tasks do
      load "evolver/tasks/db.rake"
    end
  end
end
