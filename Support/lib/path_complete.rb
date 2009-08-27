require File.dirname(__FILE__) + '/config'
module PathComplete
  class Path
    def initialize(config = {})
      Config.setup(config)
    end
    def run
      line = Config[:input]
      # str = ''
      line[/(?:'|")([^'"]+)(?:'|")?/]
      str = $1
      base_path = (str[0..0] == '/') ? Config[:project_dir] : File.dirname(Config[:file_path])
      partial_name = str.split('/')[-1].to_s
      path = str.split('/')[0..-2].join('/') + '/'
      
      items = Dir.entries(base_path + path)

      # get first item that is not an exact match
      items = items.select {|x| x.match('^'+partial_name) }
      items = items.reject {|x| x =~ /^#{partial_name}$/ }
      
      line.gsub(str, path + items.shift)
    end
  end
end
