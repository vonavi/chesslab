$:.unshift File.dirname(__FILE__) # for use/testing when no gem is installed

# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

# 3rd party
require 'active_hash'
require 'inifile'

# Internal requires
require 'chesslab/load_hash'
require 'chesslab/tournament'
require 'chesslab/player'
require 'chesslab/game'
require 'chesslab/utils'

require_all 'chesslab/commands'

module Chesslab
  extend self

  VERSION = '0.1'

  def configuration
    require 'yaml'
    config_file = File.join(Dir.pwd, 'config.yml')
    config      = YAML.load_file config_file
    config
  end

  def get_binding
    binding
  end

end
