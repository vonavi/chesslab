# coding: utf-8
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

      white_ply    = Player.find_by_name white
      black_ply    = Player.find_by_name black
      self.players = Set.new [white_ply.id, black_ply.id]
    end

    def score ply_id
      case result_by_id ply_id
      when '1' then 1.0
      when '½' then 0.5
      when '0' then 0.0
      else 0.0
      end
    end

    def result_by_id ply_id
      return '' unless result?

      case ply_id
      when Player.find_by_name(white).id
        result[0]
      when Player.find_by_name(black).id
        result[2]
      end
    end
  end
end
