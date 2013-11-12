module ChessLab
  class Tournament

    # Provide the access to the player by his name
    attr_reader :players

    require 'yaml'

    def initialize config
      @dir = config['dir']
      @title = config['title']

      # Register tournament
      ChessLab.tournaments[@dir] = self

      players_file = File.join(Dir.pwd, "#{@dir}/players.yml")
      @players_conf = YAML.load_file players_file

      # Hash @players provides the access to the player by his name
      players_arr = @players_conf.map do |config|
        player = Player.new config, @dir
        [player.name, player]
      end
      @players = Hash[players_arr]
    end

    def import_games
      games_file = File.join(Dir.pwd, "#{@dir}/games.yml")
      @games_conf = YAML.load_file games_file

      @games_conf.each do |tour|
        tour['games'].each do |config|
          white = config['white']
          black = config['black']
          result = config['result']

          case result
          when '1:0'
            @players[white].wins << black
            @players[black].losses << white
          when '0.5:0.5'
            @players[white].draws << black
            @players[black].draws << white
          when '0:1'
            @players[white].losses << black
            @players[black].wins << white
          end
        end
      end

      # Update the players' data after game import
      @players.each { |name, player| player.update }
    end

  end
end
