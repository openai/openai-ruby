# frozen_string_literal: true

require "rubygems/package"
require "tmpdir"

require_relative "test_helper"

class OpenAI::Test::GemPackagingTest < Minitest::Test
  def test_packages_azure_provider_guide_as_documentation
    specification = Gem::Specification.load(File.expand_path("../../openai.gemspec", __dir__))

    Dir.mktmpdir("openai-gem-packaging-test") do |directory|
      gem_file = File.join(directory, "openai.gem")
      Gem::Package.build(specification, false, false, gem_file)
      package = Gem::Package.new(gem_file)

      assert(package.contents.include?("azure.md"), "built gem does not include azure.md")
      assert_includes(package.spec.extra_rdoc_files, "azure.md")
    end
  end
end
