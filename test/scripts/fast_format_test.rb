# frozen_string_literal: true

require "minitest/autorun"
require "fileutils"
require "json"
require "open3"
require "rbconfig"
require "tmpdir"

class FastFormatTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)
  FAST_FORMAT = File.join(ROOT, "scripts/fast-format")

  def test_resolves_relative_path_list_from_callers_directory
    with_bundle_probe do |directory, executable_path|
      path_list = "paths.txt"
      File.write(File.join(directory, path_list), "example.rb\n")

      invocation = invoke_fast_format(executable_path, directory, path_list)

      assert_equal(ROOT, invocation.fetch("directory"))
      assert_equal(
        ["exec", "rake", "format", "FORMAT_FILE=#{File.join(directory, path_list)}"],
        invocation.fetch("arguments")
      )
    end
  end

  def test_forwards_all_arguments_after_path_list
    with_bundle_probe do |directory, executable_path|
      path_list = File.join(directory, "paths.txt")
      File.write(path_list, "example.rb\n")
      additional_arguments = ["--trace", "FORMATTER_OPTION=value with spaces"]

      invocation = invoke_fast_format(
        executable_path,
        directory,
        path_list,
        *additional_arguments
      )

      assert_equal(
        ["exec", "rake", "format", "FORMAT_FILE=#{path_list}", *additional_arguments],
        invocation.fetch("arguments")
      )
    end
  end

  private

  def invoke_fast_format(executable_path, directory, *arguments)
    env = {"PATH" => [executable_path, ENV.fetch("PATH")].join(File::PATH_SEPARATOR)}
    stdout, stderr, status = Open3.capture3(env, FAST_FORMAT, *arguments, chdir: directory)

    assert(status.success?, stderr)
    JSON.parse(stdout.lines.last)
  end

  def with_bundle_probe
    Dir.mktmpdir do |temporary_directory|
      directory = File.join(temporary_directory, "caller")
      executable_path = File.join(temporary_directory, "bin")
      FileUtils.mkdir_p([directory, executable_path])
      bundle = File.join(executable_path, "bundle")
      File.write(
        bundle,
        <<~RUBY
          #!#{RbConfig.ruby}
          require "json"

          puts JSON.generate("arguments" => ARGV, "directory" => Dir.pwd)
        RUBY
      )
      FileUtils.chmod(0o755, bundle)

      yield directory, executable_path
    end
  end
end
