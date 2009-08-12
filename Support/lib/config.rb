module Reformat
  class Config
    class << self
      def defaults
        @defaults ||= {
          :input => 'Replace me.',
          :soft_tabs => 'YES', # YES or NO
          :tab_size => 0 # integer
        }
      end
      
      def setup(settings = {})
        @configuration = defaults.merge(settings)
      end
      
      def [](key)
        (@configuration ||= defaults)[key]
      end
    end
  end
end

module PathComplete
  class Config
    class << self
      def defaults
        @defaults ||= {
          :input => 'Replace me.',
          :project_dir => ENV['TM_PROJECT_DIRECTORY'],
          :file_path => ENV['TM_FILEPATH'],
        }
      end
      
      def setup(settings = {})
        @configuration = defaults.merge(settings)
      end
      
      def [](key)
        (@configuration ||= defaults)[key]
      end
    end
  end
end