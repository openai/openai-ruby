# frozen_string_literal: true

require "minitest/autorun"
require "json"
require "open3"
require "rbconfig"
require "tmpdir"
require "yaml"

class DocsWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_docs_bundle_uses_repository_source_cooldown
    gemfile = File.read(File.join(ROOT, "docs/Gemfile"))

    assert_includes(gemfile, "source \"https://rubygems.org\", cooldown: 7")
  end

  def test_dependabot_updates_the_docs_bundle
    dependabot = YAML.safe_load_file(File.join(ROOT, ".github/dependabot.yml"))
    bundler_updates = dependabot.fetch("updates").select { _1.fetch("package-ecosystem") == "bundler" }
    root = bundler_updates.find { _1.fetch("directory") == "/" }
    docs = bundler_updates.find do |update|
      update.fetch("package-ecosystem") == "bundler" && update.fetch("directory") == "/docs"
    end

    refute_nil(docs)
    %w[schedule cooldown groups open-pull-requests-limit].each do |setting|
      assert_equal(root.fetch(setting), docs.fetch(setting))
    end
  end

  def test_rake_aliases_preserve_user_bundle_settings
    rakefile = File.read(File.join(ROOT, "Rakefile"))

    assert_equal(2, rakefile.scan("Bundler.with_original_env").length)
    refute_includes(rakefile, "Bundler.with_unbundled_env")
  end

  def test_rake_alias_passes_user_bundle_settings_to_docs_bundle
    Dir.mktmpdir do |directory|
      bundle = File.join(directory, "bundle")
      File.write(
        bundle,
        <<~RUBY
          #!#{RbConfig.ruby}
          require "json"
          puts JSON.generate(ENV.select { |key, _value| key.start_with?("BUNDLE_") })
        RUBY
      )
      File.chmod(0o755, bundle)

      mirror = "https://rubygems.org"
      env = unactivated_env.merge(
        "BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/" => mirror,
        "PATH" => [directory, File.dirname(RbConfig.ruby), ENV.fetch("PATH")].join(File::PATH_SEPARATOR)
      )
      bundler = Gem.bin_path("bundler", "bundle")
      stdout, stderr, status = Open3.capture3(
        env,
        RbConfig.ruby,
        bundler,
        "exec",
        "rake",
        "build:docs",
        chdir: ROOT
      )

      assert(status.success?, stderr)
      docs_env = JSON.parse(stdout.lines.last)
      assert_equal(mirror, docs_env.fetch("BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/"))
      assert_equal(File.join(ROOT, "docs/Gemfile"), docs_env.fetch("BUNDLE_GEMFILE"))
      refute(docs_env.key?("BUNDLE_BIN_PATH"))
    end
  end

  def test_original_env_preserves_caller_bundle_policy
    settings = {
      "BUNDLE_COOLDOWN" => "7",
      "BUNDLE_DEPLOYMENT" => "true",
      "BUNDLE_FROZEN" => "true",
      "BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/" => "https://mirror.example",
      "BUNDLE_PATH" => "/opt/bundle"
    }
    source = <<~RUBY
      require "bundler"
      require "json"

      ENV["BUNDLE_BIN_PATH"] = "/parent/bin/bundle"
      ENV["BUNDLE_GEMFILE"] = "/parent/Gemfile"
      Bundler.with_original_env do
        puts JSON.generate(ENV.select { |key, _value| #{settings.keys.inspect}.include?(key) })
        puts ENV.key?("BUNDLE_BIN_PATH")
        puts ENV.key?("BUNDLE_GEMFILE")
      end
    RUBY
    stdout, stderr, status = Open3.capture3(unactivated_env.merge(settings), RbConfig.ruby, "-e", source)

    assert(status.success?, stderr)
    lines = stdout.lines.map(&:chomp)
    assert_equal(settings, JSON.parse(lines.fetch(0)))
    assert_equal(%w[false false], lines.drop(1))
  end

  def test_dependency_review_covers_docs_manifests
    instructions = File.read(File.join(ROOT, "AGENTS.md"))

    assert_includes(instructions, "`docs/Gemfile`")
    assert_includes(instructions, "`docs/Gemfile.lock`")
  end

  private

  def unactivated_env
    keys = ENV.each_key.grep(/\A(?:BUNDLE_|BUNDLER_ORIG_)/)
    keys.concat(%w[BUNDLER_SETUP BUNDLER_VERSION RUBYLIB RUBYOPT])
    keys.to_h { [_1, nil] }
  end
end
