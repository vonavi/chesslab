$:.unshift File.dirname(__FILE__) # for use/testing when no gem is installed

# 3rd party
require 'active_hash'

# Internal requires
require_relative 'chesslab/game.rb'
require_relative 'chesslab/player.rb'
require_relative 'chesslab/tournament.rb'

module Chesslab

  @tournaments = {}

  class << self

    # Provide the access to the tournament by its directory
    attr_accessor :tournaments

    def configuration
      require 'yaml'

      config_file = File.join(Dir.pwd, 'config.yml')
      config = YAML.load_file config_file
      config
    end

  end
end
