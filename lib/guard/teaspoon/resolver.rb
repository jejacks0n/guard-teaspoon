module Guard
  class Teaspoon
    class Resolver

      attr_accessor :suites

      def initialize(options = {})
        @options = options
        #@excluded = Dir[@options[:exclude].to_s]
      end

      def resolve(original_paths)
        @suites = {}
        original_paths.uniq.each do |path|
          if result = ::Teaspoon::Suite.resolve_spec_for(path)
            suite = @suites[result[:suite]] ||= []
            suite << result[:path]
          end
        end
      end

    end
  end
end
