require "teabag/console"

module Guard
  class Teabag
    class Runner

      def initialize(options = {})
        @options = options
        @console = ::Teabag::Console.new(options)
      end

      def run_all(options = {})
        UI.info("Guard::Teabag - running all")
        @console.execute(@options.merge(options))
      end

      def run(paths = [], options = {})
        return false if paths.empty?
        paths = paths.map{ |path| File.expand_path(path) }

        #UI.info("Guard::Teabag - running #{paths.join(" ")}")
        @console.execute(@options.merge(options), paths)
      end
    end
  end
end
