module Chesslab
  class Game < ActiveYaml::Base

    # The tour number and date of game
    fields :tour, :date
    # White and black players, and the result of game
    fields :white, :black, :result

  end
end
