# frozen_string_literal: true

require "rubygems/package"
require "open3"
require "rbconfig"
require "tmpdir"
require "uri"

require_relative "test_helper"

class OpenAI::Test::GemPackagingTest < Minitest::Test
  def test_packages_every_relative_readme_link
    specification = Gem::Specification.load(File.expand_path("../../openai.gemspec", __dir__))
    readme = File.read(File.expand_path("../../README.md", __dir__))
    relative_links = readme.scan(/\[[^\]]+\]\(([^\s)]+)(?:\s+[^)]*)?\)/).flatten.filter_map do |target|
      uri = URI.parse(target)
      uri.path if uri.relative? && uri.host.nil? && !uri.path.empty?
    end

    Dir.mktmpdir("openai-gem-packaging-test") do |directory|
      gem_file = File.join(directory, "openai.gem")
      Gem::Package.build(specification, false, false, gem_file)
      package = Gem::Package.new(gem_file)

      assert_empty(relative_links - package.contents, "README links are missing from the built gem")
      assert_includes(package.contents, "examples/realtime/function_calling.rb")
      assert_includes(package.contents, "examples/realtime/image_input.rb")
      assert_includes(package.contents, "examples/realtime/mcp_approval.rb")
      assert_includes(package.contents, "examples/realtime/websocket_transcription.rb")
      assert_includes(package.contents, "examples/realtime/websocket_text.rb")
      assert_includes(package.contents, "examples/realtime/websocket_voice_turn.rb")

      package.extract_files(directory, "examples/realtime/websocket_voice_turn.rb")
      voice_turn_source = File.read(File.join(directory, "examples/realtime/websocket_voice_turn.rb"))
      refute_includes(voice_turn_source, "require \"base64\"")
      refute_match(/\bBase64\./, voice_turn_source)

      linked_guides = relative_links.select { File.extname(_1) == ".md" }
      assert_empty(linked_guides - package.spec.extra_rdoc_files, "README guides are missing from RDoc")
    end
  end

  def test_installed_gem_completes_real_x509_issuer_and_api_handshakes
    specification = Gem::Specification.load(File.expand_path("../../openai.gemspec", __dir__))
    smoke_script = File.expand_path("support/x509_installed_gem_smoke.rb", __dir__)

    Dir.mktmpdir("openai-x509-installed-gem") do |directory|
      gem_file = File.join(directory, "openai.gem")
      install_directory = File.join(directory, "install")
      Gem::Package.build(specification, false, false, gem_file)
      install_output, install_status = Open3.capture2e(
        RbConfig.ruby,
        "-S",
        "gem",
        "install",
        "--local",
        "--ignore-dependencies",
        "--no-document",
        "--install-dir",
        install_directory,
        gem_file
      )
      assert_predicate(install_status, :success?, install_output)

      environment = {
        "GEM_HOME" => install_directory,
        "GEM_PATH" => ([install_directory] + Gem.path).join(File::PATH_SEPARATOR),
        "BUNDLE_GEMFILE" => nil,
        "RUBYOPT" => nil,
        "RUBYLIB" => nil
      }
      output, status = Open3.capture2e(environment, RbConfig.ruby, smoke_script, chdir: directory)
      assert_predicate(status, :success?, output)
      assert_includes(output, "installed gem X.509 issuer/API mTLS verification passed")
    end
  end
end
