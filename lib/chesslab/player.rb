module ChessLab
  class Player

    # Player's name, number and Elo rating
    attr_reader :name, :number, :elo

    # If the player wins, makes a draw or losses, the opponent is
    # stored in the corresponding list
    attr_accessor :wins, :draws, :losses

    # The number of games played by the player and his score
    attr_reader :games, :score

    def initialize config, trn_dir
      @name = config['name']
      @number = config['number']
      @elo = config['elo'] || 1200
      @trn_dir = trn_dir

      @wins = []
      @draws = []
      @losses = []
      @games = 0
      @score = 0.0
    end

    def update
      @games = @wins.size + @draws.size + @losses.size
      @score = 1.0 * @wins.size + 0.5 * @draws.size
    end

    # Player's Sonneborn-Berger score
    def berger
      players = ChessLab.tournaments[@trn_dir].players

      @wins.inject(0.0) { |sum, name| sum + players[name].score } +
        0.5 * @draws.inject(0.0) { |sum, name| sum + players[name].score }
    end

  end
end
