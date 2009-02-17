require File.dirname(__FILE__) + '/config'
module Reformat
  class CSS
    def initialize(config = {})
      Config.setup(config)
      @tab_chars = ( Config[:soft_tabs] == 'YES' ) ? ' ' * Config[:tab_size].to_i : "\t"
    end
    def run
      # split by each line
      lines = Config[:input].split(/\;|\n/)
      
      # strip whitespace and remove any blank or bracketed lines
      lines.each { |x| ['{', '}'].each { |y| x.gsub!(y, '') }; x.strip!; }.delete_if { |x| x.empty? }
      
      # entab the lines to match preferences
      lines.collect! { |x| @tab_chars + x }.sort!
      
      output = ''
      if ( lines.length > 1 )
        output << "{\n" unless !Config[:input]["{"]
        output << lines.join(";\n")
        output << "\n}" unless !Config[:input]["}"]
      else
        output << "{ " unless !Config[:input]["{"]
        output << lines.collect { |x| x.strip! }.join('; ')
        output << " }" unless !Config[:input]["}"]
      end
      
      output
    end
  end
end