module Chesslab
  module Commands
    class Table

      def self.generate args, options = {}
        Tournament.process

        template     = File.read 'templates/round_robin_table.html.erb'
        table        = ERB.new template, nil, '-'
        html_content = table.result Chesslab.get_binding
        puts html_content
      end

    end
  end
end
