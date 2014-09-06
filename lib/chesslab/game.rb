require 'set'

module Chesslab
  class Game < Chesslab::LoadHash

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
      white_id = Player.find_by_name(white).id
      black_id = Player.find_by_name(black).id

      case
      when ((result == '1-0' && ply_id == white_id) ^
            (result == '0-1' && ply_id == black_id))
        1.0
      when (result == '1/2' &&
            (ply_id == white_id || ply_id == black_id))
        0.5
      when ((result == '0-1' && ply_id == white_id) ^
            (result == '1-0' && ply_id == black_id))
        0.0
      end
    end

  end
end
