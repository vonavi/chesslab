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
        @ini_sections = []
        @ini_file     = IniFile.load path
        @ini_file.each_section do |section|
          @ini_sections << @ini_file[section]
        end
        @ini_sections
      end

    end
  end
end
