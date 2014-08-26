require 'set'

module Chesslab
  class Game < ActiveYaml::Base

    # Tournament round
    field :round, :default => 1
    # The tour number and date of game
    fields :tour, :date
    # White and black players, and the result of game
    fields :white, :black, :result
    # Players of game
    field :players

    def initialize *args, &blk
      super

      white_ply = Player.find_by_name white
      black_ply = Player.find_by_name black
      self.players = Set.new [white_ply.id, black_ply.id]
    end

    def score ply_id
    end

  end
end
