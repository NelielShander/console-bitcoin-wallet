require 'rspec'
require 'benchmark'
require 'zeitwerk'
loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/../lib")
loader.push_dir(__dir__.to_s)
loader.setup

module SpecHelper
  def profile_memory
    memory_usage_before = `ps -o rss= -p #{Process.pid}`.to_i
    yield
    memory_usage_after = `ps -o rss= -p #{Process.pid}`.to_i
    used_memory = ((memory_usage_after - memory_usage_before) / 1024.0).round(2)
    $stdout.puts "Memory usage: #{used_memory} MB"
  end

  def profile_time(&)
    time_elapsed = Benchmark.realtime(&)

    $stdout.puts "Time: #{time_elapsed.round(2)} seconds"
  end

  def profile_gc
    GC.start
    before = GC.stat(:total_freed_objects)
    yield
    GC.start
    after = GC.stat(:total_freed_objects)

    $stdout.puts "Objects Freed: #{after - before}"
  end

  def profile(&block)
    profile_memory do
      profile_time do
        profile_gc(&block)
      end
    end
  end
end
