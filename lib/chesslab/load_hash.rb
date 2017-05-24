module Chesslab
  class LoadHash < ActiveFile::Base
    extend ActiveFile::HashAndArrayFiles
    class << self

      def load_file
        if (data = raw_data).is_a?(Array)
          data
        else
          data.values
        end
      end

      def extension
        "ini"
      end

      private
      def load_path path
        @ini_file = IniFile.load path
        @ini_file.to_h.values.each_with_index.map do |x, i|
          hash = { :id => i + 1 }
          x.each { |k, v| hash[k.to_sym] = v }
          hash
        end
      end

    end
  end
end
