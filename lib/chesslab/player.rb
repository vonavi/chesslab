module Chesslab
  class Player < Chesslab::LoadHash

    # Player's name and Elo rating, stored in file
    field :name
    field :elo, :default => 1500

    # Store a player's opponent in a list corresponding to a result
    # that the player has against him
    attr_accessor :wins, :draws, :losses, :pluses, :minuses

    # The number of games played by the player and his points
    attr_reader :games, :points

    @@players_less_half = []

    def initialize *args, &blk
      super
      @wins, @draws, @losses = [], [], []
      @pluses, @minuses      = [], []
      @games, @points        = 0, 0.0
    end

    # Less than 50% of games were played
    def less_half?
      @wins.size + @draws.size + @losses.size < @minuses.size
    end

    # Players with less than 50% of games played
    def self.less_half
      @@players_less_half |= Player.all
                            .select { |ply| ply.less_half? }
                            .map { |ply| ply.id }
    end

    def process
      @games = @wins.size + @draws.size + @losses.size

      unless less_half?
        @points += (@wins - Player.less_half).size
        @points += (@draws - Player.less_half).size * 0.5
        @points += (@pluses - Player.less_half).size
      end
    end

    # Player's Sonneborn-Berger score
    def berger
      berger = 0.0
      return berger if less_half?

      berger += (@wins - Player.less_half)
               .map { |id| Player.find_by_id(id).points }
               .reduce(0.0, :+)
      berger += (@draws - Player.less_half)
               .map { |id| Player.find_by_id(id).points }
               .reduce(0.0, :+) * 0.5
      berger += (@pluses + @minuses - Player.less_half)
               .size * @points * 0.5
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
