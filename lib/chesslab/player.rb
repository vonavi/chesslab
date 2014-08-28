module Chesslab
  class Player < ActiveYaml::Base

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

    def place
    end

    # Player's Sonneborn-Berger score
    def berger
      @wins.map { |id| Player.find_by_id(id).points }.reduce(0.0, :+) +
        0.5 * @draws.map { |id| Player.find_by_id(id).points }.reduce(0.0, :+)
    end

  end
end
