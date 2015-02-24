require "guard/plugin"

module Guard
  class Teaspoon < Plugin
    require "guard/teaspoon/resolver"
    require "guard/teaspoon/runner"

    attr_accessor :runner, :resolver, :failed_paths, :last_failed

    def initialize(options = {})
      super
      @options = {
        focus_on_failed:      false,
        all_after_pass:       true,
        all_on_start:         true,
        keep_failed:          true,
        formatters:           'clean',
        run_all:              {},
        run_on_modifications: {}
      }.merge(options)
    end

    def start
      reload
      @resolver = Resolver.new(@options)
      @runner = Runner.new(@options)
      UI.info "Guard::Teaspoon is running"
      run_all if @options[:all_on_start]
    end

    def run_all
      passed = @runner.run_all(@options[:run_all])

      if passed
        notify(:success)
        reload
        true
      else
        notify(:failed)
        @last_failed = true
        throw :task_has_failed
      end
    end

    def reload
      @last_failed = false
      @failed_paths = []
    end

    def run_on_modifications(original_paths)
      @resolver.resolve(original_paths)

      failed = false
      @resolver.suites.each do |suite, files|
        failed = true unless @runner.run(files, @options[:run_on_modifications].merge(suite: suite))
      end

      if failed
        @last_failed = true
        notify(:failed)
        throw :task_has_failed
      else
        notify(:success)
        run_all if @last_failed
      end
    end

    private

    def notify(status)
      UI.info(status.to_s.capitalize, title: "Teaspoon Guard", image: status)
    end

    def remove_failed(paths)
      @failed_paths -= paths if @options[:keep_failed]
    end

    def add_failed(paths)
      if @options[:keep_failed]
        @failed_paths += paths
        @failed_paths.uniq!
      end
    end
  end
end
