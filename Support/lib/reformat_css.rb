require File.dirname(__FILE__) + '/config'
module Reformat
  class CSS
    def initialize(config = {})
      Config.setup(config)
      @tab_chars = ( Config[:soft_tabs] == 'YES' ) ? ' ' * Config[:tab_size].to_i : "\t"
    end
    def run
      # remove any extraneous whitespace
      lines = Config[:input].strip
      
      # remove any leading and trailing braces (noting for later re-inclusion)
      if lines =~ /^\{/
        lines = lines[1..-1]
        first_bracket = true
      end
      if lines =~ /\}$/
        lines = lines[0...-1]
        last_bracket = true
      end
      
      # split by each line
      lines = lines.split(/\n/)
      
      # split up multiple statments in one line
      if lines.length == 1
        lines = lines.first.split(/;|\*\//)
        
        # put comments back with their respective lines
        lines.each_with_index { |x,i|
          if x.match(/\/\*/)
            lines[i-1] << ';' if lines[i-1].match(';').nil?
            lines[i-1] << x
            lines.delete(x)
          end
        }
      end
      
      # strip whitespace and remove any blank or bracketed lines
      lines.each { |x| x.strip! }.delete_if { |x| x.empty? }
      
      # entab the lines to match preferences and always end in a semicolon
      lines.collect! do |x|
        # put back end comments where needed
        if x.match(/\/\*/) && !x.match(/\*\//)
          @tab_chars + x << ' */'
        else
          @tab_chars + x + ( x.match(';').nil? ? ';' : '')
        end
      end
      
      # TODO implement some custom sorting
      lines.sort!
      
      # reassemble with on one or many lines and with appropriate brackets from the original
      output = ''
      if ( lines.length > 1 )
        output << "{\n" unless first_bracket.nil?
        output << lines.join("\n")
        output << "\n}" unless last_bracket.nil?
      else
        output << "{ " unless first_bracket.nil?
        output << lines.collect { |x| x.strip! }.join('; ')
        output << " }" unless last_bracket.nil?
      end
      
      output
    end
  end
end