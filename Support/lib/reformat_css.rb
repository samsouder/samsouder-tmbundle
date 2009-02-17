#!/usr/bin/env ruby
# INPUT = "{
#   position: absolute;
#   top: 0;
#   right: 0;
#   left: 0;
#   padding: 1px 15px 0 15px;
#   height: 15px;
#   line-height: 1.2em;
#   color: #999;
#   text-transform: uppercase;
#   font-weight: bold;
#   border: 1px solid #aaa;
#   background: #ddd;
#   -webkit-border-top-left-radius: 5px;
#   -webkit-border-top-right-radius: 5px;
#   -moz-border-radius-topleft: 5px;
#   -moz-border-radius-topright: 5px;
# }"
# INPUT = "{
#   -moz-border-radius-topleft: 5px;
# }"
# INPUT = "
#   position: absolute;
#   top: 0;
#   color: #999;
#   right: 0;
#   -webkit-border-top-left-radius: 5px;
#   -moz-border-radius-topright: 5px;
# "
# INPUT = "{ color: red; background-position: left 0; }"
# INPUT = " color: red; background-position: left 0; "
# ENV['TM_SOFT_TABS'] = 'YES'
# ENV['TM_TAB_SIZE'] = '2'
# text = INPUT
text = STDIN.read

# split by each line
out_text = text.split(/\;|\n/)

# strip whitespace and remove any blank or bracketed lines
out_text = out_text.each { |x| x.strip!; x.gsub!('{ ', '') }.delete_if { |x| ['{', '}', '{}', ''].include? x }

out_text.collect! { |x| ( ( ENV['TM_SOFT_TABS'] == 'YES' ) ? ' ' * ENV['TM_TAB_SIZE'].to_i : "\t" ) + x }.sort!

# puts out_text.inspect

if ( out_text.size > 1 )
  print "{\n" unless !text["{"]
  print out_text.join(";\n")
  print "\n}" unless !text["}"]
else
  print "{ " unless !text["{"]
  print out_text.collect { |x| x.strip! }.join('; ')
  print " }" unless !text["}"]
end
