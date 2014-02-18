require "guard"
require "guard/plugin"

module Guard
  class Teaspoon < Plugin
    require "guard/teaspoon/resolver"
    require "guard/teaspoon/runner"

    attr_accessor :runner, :failed_paths, :last_failed

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
      failed = @runner.run_all(@options[:run_all])

      if failed
        @last_failed = true
        throw :task_has_failed
      else
        @last_failed = false
        true
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
        failed = @runner.run(files, @options[:run_on_modifications].merge(suite: suite))
      end

      if failed
        @last_failed = true
        Notifier.notify("Failed", title: "Teaspoon Guard", image: :failed)
        throw :task_has_failed
      else
        Notifier.notify("Success", title: "Teaspoon Guard", image: :success)
        run_all if @last_failed
      end
    end

    private

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
