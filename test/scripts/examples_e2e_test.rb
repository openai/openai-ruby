# frozen_string_literal: true

require "minitest/autorun"
require "pathname"
require "tmpdir"
require "yaml"

require_relative "../../scripts/examples-e2e"

class ExamplesE2EInventoryTest < Minitest::Test
  def test_rejects_non_string_exclusion_reasons
    [nil, false, 1, []].each do |reason|
      with_inventory(status: "excluded", reason: reason) do |inventory|
        error = assert_raises(OpenAIExamplesE2E::ConfigurationError) { inventory.validate! }

        assert_includes(error.message, "excluded examples need a non-empty string reason")
      end
    end
  end

  def test_accepts_a_non_empty_string_exclusion_reason
    with_inventory(status: "excluded", reason: "Requires separate credentials.") do |inventory|
      assert_same(inventory, inventory.validate!)
    end
  end

  private

  def with_inventory(status:, reason:)
    Dir.mktmpdir("openai-examples-e2e-test") do |directory|
      root = Pathname(directory)
      example_path = root.join("examples/example.rb")
      example_path.dirname.mkpath
      example_path.write("# frozen_string_literal: true\n")

      manifest_path = root.join("examples/e2e.yml")
      manifest_path.write(
        YAML.dump(
          "version" => 1,
          "examples" => {
            "examples/example.rb" => {"status" => status, "reason" => reason}
          }
        )
      )

      yield(OpenAIExamplesE2E::Inventory.new(root: root, manifest_path: manifest_path))
    end
  end
end
