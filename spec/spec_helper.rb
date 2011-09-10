$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "bomb_defuser"
require "rspec"
require "webmock/rspec"

include BombDefuser

FIXTURES_PATH = File.expand_path(File.dirname(__FILE__) + "/fixtures")

Configuration.logger = Logger.new(nil)
