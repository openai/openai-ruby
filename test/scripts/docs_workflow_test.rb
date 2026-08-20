# frozen_string_literal: true

require "minitest/autorun"
require "fileutils"
require "json"
require "open3"
require "rbconfig"
require "tmpdir"
require "yaml"

class DocsWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)
  BUNDLER = Gem.bin_path("bundler", "bundle")
  DOCS_GEMFILE = File.join(ROOT, "docs/Gemfile")
  DOCS_LOCKFILE = File.join(ROOT, "docs/Gemfile.lock")

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

  def test_docs_script_defaults_to_repository_config_and_docs_lockfile
    Dir.mktmpdir do |directory|
      bundle = write_bundle_probe(directory)
      env = unactivated_env.merge(
        "BUNDLE_LOCKFILE" => File.join(ROOT, "Gemfile.lock"),
        "PATH" => executable_path(directory)
      )

      %w[install build preview].each do |command|
        stdout, stderr, status = Open3.capture3(env, File.join(ROOT, "scripts/docs"), command)

        assert(status.success?, stderr)
        docs = JSON.parse(stdout)
        assert_equal(File.join(ROOT, ".bundle"), docs.fetch("app_config_path"))
        assert_equal(DOCS_GEMFILE, docs.fetch("gemfile"))
        assert_equal(DOCS_LOCKFILE, docs.fetch("lockfile"))
      end

      assert(File.executable?(bundle))
    end
  end

  def test_docs_script_resolves_explicit_relative_config_from_repository_root
    Dir.mktmpdir do |directory|
      write_bundle_probe(directory)
      app_config = "relative-bundle-config"
      env = unactivated_env.merge(
        "BUNDLE_APP_CONFIG" => app_config,
        "PATH" => executable_path(directory)
      )

      stdout, stderr, status = Open3.capture3(env, File.join(ROOT, "scripts/docs"), "install")

      assert(status.success?, stderr)
      docs = JSON.parse(stdout)
      assert_equal(File.join(ROOT, app_config), docs.fetch("app_config_path"))
    end
  end

  def test_rake_aliases_preserve_explicit_config_and_select_docs_lockfile
    Dir.mktmpdir do |directory|
      write_bundle_probe(directory)
      app_config = "relative-bundle-config"
      env = unactivated_env.merge(
        "BUNDLE_APP_CONFIG" => app_config,
        "BUNDLE_LOCKFILE" => File.join(ROOT, "Gemfile.lock"),
        "PATH" => executable_path(directory)
      )

      %w[build:docs docs:preview].each do |task|
        stdout, stderr, status = Open3.capture3(
          env,
          RbConfig.ruby,
          BUNDLER,
          "exec",
          "rake",
          task,
          chdir: ROOT
        )

        assert(status.success?, stderr)
        docs = JSON.parse(stdout.lines.last)
        assert_equal(File.join(ROOT, app_config), docs.fetch("app_config_path"))
        assert_equal(DOCS_GEMFILE, docs.fetch("gemfile"))
        assert_equal(DOCS_LOCKFILE, docs.fetch("lockfile"))
        refute(docs.fetch("env").key?("BUNDLE_BIN_PATH"))
      end
    end
  end

  def test_docs_install_cannot_modify_primary_bundle_files
    Dir.mktmpdir do |directory|
      project = File.join(directory, "project")
      prepare_bundle_fixture(project)
      primary_lockfile = File.join(project, "Gemfile.lock")
      primary_config = File.join(project, ".bundle/config")
      docs_lockfile = File.join(project, "docs/Gemfile.lock")
      originals = [primary_lockfile, primary_config, docs_lockfile].to_h { [_1, File.binread(_1)] }
      env = unactivated_env.merge(
        "BUNDLE_LOCKFILE" => primary_lockfile,
        "PATH" => executable_path
      )

      _stdout, stderr, status = Open3.capture3(
        env,
        File.join(project, "scripts/docs"),
        "install",
        "--local"
      )

      assert(status.success?, stderr)
      originals.each do |path, content|
        assert_equal(content, File.binread(path), "Expected #{path} to remain unchanged")
      end
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

  def bundle_lock(project, gemfile, lockfile)
    env = unactivated_env.merge(
      "BUNDLE_APP_CONFIG" => File.join(project, "seed-config"),
      "BUNDLE_GEMFILE" => gemfile,
      "BUNDLE_LOCKFILE" => lockfile,
      "PATH" => executable_path
    )
    _stdout, stderr, status = Open3.capture3(env, RbConfig.ruby, BUNDLER, "lock", "--local", chdir: project)

    assert(status.success?, stderr)
  end

  def executable_path(directory = nil)
    [directory, File.dirname(RbConfig.ruby), ENV.fetch("PATH")].compact.join(File::PATH_SEPARATOR)
  end

  def prepare_bundle_fixture(project)
    FileUtils.mkdir_p(File.join(project, ".bundle"))
    FileUtils.mkdir_p(File.join(project, "docs/fixture/lib"))
    FileUtils.mkdir_p(File.join(project, "scripts"))
    File.symlink(File.join(ROOT, "scripts/docs"), File.join(project, "scripts/docs"))
    File.write(File.join(project, "Gemfile"), "source \"https://rubygems.org\"\n")
    File.write(
      File.join(project, "docs/Gemfile"),
      <<~RUBY
        source "https://rubygems.org"
        gem "docs_fixture", path: "fixture"
      RUBY
    )
    File.write(
      File.join(project, "docs/fixture/docs_fixture.gemspec"),
      <<~RUBY
        Gem::Specification.new do |spec|
          spec.name = "docs_fixture"
          spec.version = "1.0.0"
          spec.summary = "Docs workflow test fixture"
          spec.authors = ["OpenAI"]
          spec.files = ["lib/docs_fixture.rb"]
        end
      RUBY
    )
    File.write(File.join(project, "docs/fixture/lib/docs_fixture.rb"), "# frozen_string_literal: true\n")
    bundle_lock(project, File.join(project, "Gemfile"), File.join(project, "Gemfile.lock"))
    bundle_lock(project, File.join(project, "docs/Gemfile"), File.join(project, "docs/Gemfile.lock"))
    File.write(
      File.join(project, ".bundle/config"),
      <<~YAML
        ---
        BUNDLE_FROZEN: "true"
        BUNDLE_PATH: "vendor/repository-bundle"
      YAML
    )
  end

  def write_bundle_probe(directory)
    bundle = File.join(directory, "bundle")
    File.write(
      bundle,
      <<~RUBY
        #!#{RbConfig.ruby}
        require "bundler"
        require "json"

        puts JSON.generate(
          "app_config_path" => Bundler.app_config_path.to_s,
          "env" => ENV.select { |key, _value| key.start_with?("BUNDLE_") },
          "gemfile" => Bundler.default_gemfile.to_s,
          "lockfile" => Bundler.default_lockfile.to_s
        )
      RUBY
    )
    File.chmod(0o755, bundle)
    bundle
  end

  def unactivated_env
    keys = ENV.each_key.grep(/\A(?:BUNDLE_|BUNDLER_ORIG_)/)
    keys.concat(%w[BUNDLER_SETUP BUNDLER_VERSION RUBYLIB RUBYOPT])
    keys.to_h { [_1, nil] }
  end
end
