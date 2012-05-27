# encoding: utf-8
require "evolver/config/environment"

module Evolver
  module Config
    extend self

    def load!(path, environment = nil)
      settings = Environment.load_yaml(path, environment)
      load_configuration(settings) if settings.present?
      settings
    end

    def sessions
      @sessions ||= {}
    end

    def sessions=(sessions)
      @sessions = sessions.with_indifferent_access
    end

    private

    def load_configuration(settings)
      configuration = settings.with_indifferent_access
      self.sessions = configuration[:sessions]
    end
  end
end
