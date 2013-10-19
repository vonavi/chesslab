$:.unshift File.dirname(__FILE__) # for use/testing when no gem is installed

# Internal requires
require 'chesslab/player.rb'
require 'chesslab/tourney.rb'

module ChessLab

  @tourneys = {}

  class << self

    # Provide the access to the tourney by its directory
    attr_accessor :tourneys

    def configuration
      require 'yaml'

      config_file = File.join(Dir.pwd, 'config.yml')
      config = YAML.load_file config_file
      config
    end

  end
end
