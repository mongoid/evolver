# encoding: utf-8
module Evolver
  module Config
    extend self

    def load!(path)
      settings = load_yaml(path, environment)
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

    def load_yaml(path)
      YAML.load(ERB.new(File.new(path).read).result)[Rails.env]
    end
  end
end
