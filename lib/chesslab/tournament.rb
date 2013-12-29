module Chesslab
  class Tournament

    def initialize config
      @dir = config['dir']
      @title = config['title']

      # Register tournament
      Chesslab.tournaments[@dir] = self

      # Set the default file location
      ActiveFile::Base.set_root_path File.join(Dir.pwd, @dir)
    end

    def import_games
      Game.all.each do |game|
        white = Player.find_by_name game.white
        black = Player.find_by_name game.black
        result = game.result

        case result
        when '1:0'
          white.wins << black.id
          black.losses << white.id
        when '0.5:0.5'
          white.draws << black.id
          black.draws << white.id
        when '0:1'
          white.losses << black.id
          black.wins << white.id
        end
      end

      # Update the players' data after game import
      Player.all.each { |player| player.update }
    end

  end
end
