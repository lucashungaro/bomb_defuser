$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "giant_bomb"
require "rspec"
require "webmock/rspec"

include GiantBomb

FIXTURES_PATH = File.expand_path(File.dirname(__FILE__) + "/fixtures")

Configuration.logger = Logger.new(nil)
