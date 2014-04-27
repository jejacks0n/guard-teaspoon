module Guard
  class Teaspoon
    class Runner

      attr_accessor :console

      def initialize(options = {})
        @options = options

        begin
          require "teaspoon/console"
          @console = ::Teaspoon::Console.new(@options)
        rescue ::Teaspoon::EnvironmentNotFound => e
          STDOUT.print "Unable to load Teaspoon environment in {#{::Teaspoon::Environment.standard_environments.join(', ')}}.\n"
          STDOUT.print "Consider using -r path/to/teaspoon_env\n"
          abort
        end
      end

      def run_all(options = {})
        @console.execute(@options.merge(options))
      end

      def run(files = [], options = {})
        return false if files.empty?
        @console.execute(@options.merge(options).merge(files: files))
      end

      private

      def abort
        exit(1)
      end
    end
  end
end
