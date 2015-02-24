module Guard
  class Teaspoon
    class Runner
      attr_accessor :console

      def initialize(options = {})
        @options = options

        begin
          require "teaspoon/console"
          @console = ::Teaspoon::Console.new(@options)
        rescue ::Teaspoon::EnvironmentNotFound
          environments = ::Teaspoon::Environment.standard_environments.join(", ")
          STDOUT.print "Unable to load Teaspoon environment in {#{environments}}.\n"
          STDOUT.print "Consider using -r path/to/teaspoon_env\n"
          abort
        end
      end

      def run_all(options = {})
        # run all tests instead of running only the last run tests
        @options.delete :files
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
