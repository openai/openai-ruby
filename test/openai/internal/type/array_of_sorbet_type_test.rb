# frozen_string_literal: true

require "open3"
require "rbconfig"

require_relative "../../test_helper"

class OpenAI::Test::ArrayOfSorbetTypeTest < Minitest::Test
  def test_nullable_elements_are_preserved_in_sorbet_types
    stdout, stderr, status = Open3.capture3(
      {"RUBYOPT" => nil},
      RbConfig.ruby,
      "-I",
      File.expand_path("../../../../lib", __dir__),
      "-rsorbet-runtime",
      "-ropenai",
      "-e",
      "puts OpenAI::ArrayOf[Integer, nil?: true].to_sorbet_type"
    )

    assert_predicate(status, :success?, stderr)
    assert_equal("T::Array[T.nilable(Integer)]\n", stdout)
  end
end
