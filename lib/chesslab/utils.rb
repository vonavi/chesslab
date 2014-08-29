# -*- coding: utf-8 -*-
module Chesslab
  module Utils
    extend self

    # Replace the fractional part of number
    def symbolize_frac number
      case number
      when 0
        return '0'
      when 0.5
        return '½'
      end

      str  = Float(number).to_s
      frac = str.split '.'
      str  = case frac[1]
      when '0'
        frac[0]
      when '5'
        frac[0] + '½'
      end
      str
    end

  end
end
