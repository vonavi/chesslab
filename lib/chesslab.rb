$:.unshift File.dirname(__FILE__) # for use/testing when no gem is installed

# Internal requires
require 'chesslab/player.rb'
require 'chesslab/tournament.rb'

module ChessLab

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
