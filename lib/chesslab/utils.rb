# -*- coding: utf-8 -*-
module Chesslab
  module Utils
    extend self

    # Replace the fractional part of number
    def symbolize_frac number
      return '' unless number
      return '0' if number == 0

      str       = Float(number).to_s
      frac      = str.split '.'
      frac_part = case frac[1]
                  when '0'  then ''
                  when '25' then '¼'
                  when '5'  then '½'
                  when '75' then '¾'
                  end
      if frac_part
        int_part = (frac[0] == '0') ? '' : frac[0]
        str = int_part + frac_part
      end
      str
    end

  end
end
