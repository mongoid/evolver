$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "spec"))

require "evolver"
require "rspec"

require "db/evolver/migrations/20120519113509_rename_bands_to_artists"
require "db/evolver/migrations/20120520152200_add_likes_to_label"

module Rails
  extend self

  def env
    "test"
  end

  def root
    File.join(Dir.pwd, "spec")
  end
end

Mongoid.load!(File.join(File.dirname(__FILE__), "config", "mongoid.yml"))
