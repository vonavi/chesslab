module Chesslab
  module Tournament
    extend self

    attr_reader :title, :path, :rounds

    def players
      @players ||= Player.all
    end

    def process
      setup
      process_games
    end

    def setup
      config  = Chesslab.configuration['tournament'].first
      @title  = config['title']
      @path   = config['path']
      @rounds = config['rounds'] || 1

      # Set the default file location
      ActiveFile::Base.set_root_path File.join(Dir.pwd, @path)
    end

    def process_games
      Game.all.each do |game|
        white  = Player.find_by_name game.white
        black  = Player.find_by_name game.black
        result = game.result

        unless result.nil?
          white.add_result result[0], black
          black.add_result result[2], white
        end
      end

      # Update the players' data after game import
      Player.all.each { |player| player.process }
      # Sort players by their tournament ranking
      @players = players.sort
    end

  end
end
