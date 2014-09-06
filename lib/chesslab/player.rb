module Chesslab
  class Player < Chesslab::LoadHash

    # Player's name and Elo rating, stored in file
    field :name
    field :elo, :default => 1500

    # If the player wins, makes a draw or losses, the opponent is
    # stored in the corresponding list
    attr_accessor :wins, :draws, :losses

    # The number of games played by the player and his points
    attr_reader :games, :points

    def initialize *args, &blk
      super
      @wins, @draws, @losses = [], [], []
      @games = 0
      @points = 0.0
    end

    def process
      @games = @wins.size + @draws.size + @losses.size
      @points = 1.0 * @wins.size + 0.5 * @draws.size
    end

    # Player's Sonneborn-Berger score
    def berger
      @wins.map { |id| Player.find_by_id(id).points }.reduce(0.0, :+) +
        0.5 * @draws.map { |id| Player.find_by_id(id).points }.reduce(0.0, :+)
    end

    def <=> other
      # Ranking by points
      cmp = other.points <=> self.points
      return cmp if cmp != 0

      # Ranking by the Sonneborn-Berger score
      cmp = other.berger <=> self.berger
      return cmp if cmp != 0

      # Ranking by direct encounter(s) between the players
      encounters   = Game.find_all_by_players Set.new([self.id, other.id])
      scores       = encounters.map { |game| game.score self.id }
                       .compact.reduce(0.0, :+)
      other_scores = encounters.map { |game| game.score other.id }
                       .compact.reduce(0.0, :+)
      cmp          = other_scores <=> scores
      return cmp
    end

  end
end
