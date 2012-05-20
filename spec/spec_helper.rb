$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "spec"))

require "evolver"
require "rspec"

require "db/evolver/migrations/20120519113509-rename_bands_to_artists"
require "db/evolver/migrations/20120520152200-add_likes_to_label"

Moped.logger.level = Logger::DEBUG
