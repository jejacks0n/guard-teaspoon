require "guard"
require "guard/guard"

module Guard
  class Teaspoon < Guard
    autoload :Runner,   "guard/teaspoon/runner"
    autoload :Resolver, "guard/teaspoon/resolver"

    attr_accessor :runner, :failed_paths, :last_failed

    def initialize(watchers = [], options = {})
      super
      @options = {
        focus_on_failed: false,
        all_after_pass:  true,
        all_on_start:    true,
        keep_failed:     true,
        formatters:      "clean",
        run_all:         {},
        run_on_changes:  {}
      }.merge(options)
      reload

      @resolver = Resolver.new(@options)
      @runner = Runner.new(@options)
    end

    def start
      UI.info "Guard::Teaspoon is running"
      run_all if @options[:all_on_start]
    end

    def run_all
      passed = @runner.run_all(@options[:run_all])

      unless @last_failed = !passed
        @failed_paths = []
      else
        throw :task_has_failed
      end
    end

    def reload
      @last_failed = false
      @failed_paths = []
    end

    def run_on_changes(original_paths)
      @resolver.resolve(original_paths)

      failed = false
      @resolver.suites.each do |suite, files|
        failed = @runner.run(files, @options[:run_on_changes].merge(suite: suite))
      end

      if failed
        @last_failed = true
        Notifier.notify("Failed", title: "Teaspoon Guard", image: :failed)
      else
        Notifier.notify("Success", title: "Teaspoon Guard", image: :success)
      end

      #original_paths = paths.dup
      #
      #focused = false
      #if last_failed && @options[:focus_on_failed]
      #  path = './tmp/teaspoon_guard_result'
      #  if File.exist?(path)
      #    # todo: this should ask a "resolver" to see if it's a spec or not
      #    single_spec = paths && paths.length == 1 && paths[0].include?("_spec") ? paths[0] : nil
      #    failed_specs = File.open(path) { |file| file.read.split("\n") }
      #
      #    File.delete(path)
      #
      #    if single_spec && @inspector.clean([single_spec]).length == 1
      #      failed_specs = failed_specs.select{|p| p.include? single_spec}
      #    end
      #
      #    if failed_specs.any?
      #      # some sane limit, stuff will explode if all tests fail
      #      #   ... cap at 10
      #
      #      paths = failed_specs[0..10]
      #      focused = true
      #    end
      #
      #    # switch focus to the single spec
      #    focused = true if single_spec and failed_specs.length > 0
      #  end
      #end
      #
      #if focused
      #  add_failed(original_paths)
      #  add_failed(paths.map{|p| p.split(":")[0]})
      #else
      #  paths += failed_paths if @options[:keep_failed]
      #  paths = @inspector.clean(paths)
      #end
      #
      #if @runner.run(paths)
      #  remove_failed(paths) unless focused
      #
      #  if last_failed && focused
      #    run_on_changes(failed_paths)
      #  elsif last_failed && @options[:all_after_pass]
      #    @last_failed = false
      #    run_all
      #  end
      #else
      #  @last_failed = true
      #  add_failed(paths) unless focused
      #
      #  throw :task_has_failed
      #end
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
