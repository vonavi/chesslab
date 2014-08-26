module Chesslab
  class Player < ActiveYaml::Base

    # Player's name and Elo rating, stored in file
    field :name
    field :elo, :default => 1500

    # If the player wins, makes a draw or losses, the opponent is
    # stored in the corresponding list
    attr_accessor :wins, :draws, :losses

    # The number of games played by the player and his score
    attr_reader :games, :score

    def initialize *args, &blk
      super
      @wins, @draws, @losses = [], [], []
      @games = 0
      @score = 0.0
    end

    def update
      @games = @wins.size + @draws.size + @losses.size
      @score = 1.0 * @wins.size + 0.5 * @draws.size
    end

    def place
    end

    # Player's Sonneborn-Berger score
    def berger
    end

  end
end
