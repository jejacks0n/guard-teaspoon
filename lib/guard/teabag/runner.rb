module Guard
  class Teabag
    class Runner

      attr_accessor :console

      def initialize(options = {})
        @options = options

        begin
          require "teabag/console"
          @console = ::Teabag::Console.new(@options)
        rescue ::Teabag::EnvironmentNotFound => e
          STDOUT.print "Unable to load Teabag environment in {#{::Teabag::Environment.standard_environments.join(', ')}}.\n"
          STDOUT.print "Consider using -r path/to/teabag_env\n"
          abort
        end
      end

      def run_all(options = {})
        @console.execute(@options.merge(options))
      end

      def run(paths = [], options = {})
        return false if paths.empty?
        @console.execute(@options.merge(options), paths)
      end

      private

      def abort
        exit(1)
      end
    end
  end
end
