# frozen_string_literal: true

require "open3"
require "rbconfig"

require_relative "../../test_helper"

class OpenAI::Test::CollectionSorbetTypeTest < Minitest::Test
  def test_collection_element_nullability_is_preserved_in_sorbet_types
    stdout, stderr, status = Open3.capture3(
      {"RUBYOPT" => nil},
      RbConfig.ruby,
      "-I",
      File.expand_path("../../../../lib", __dir__),
      "-rsorbet-runtime",
      "-ropenai",
      "-e",
      <<~RUBY
        puts OpenAI::ArrayOf[Integer].to_sorbet_type
        puts OpenAI::ArrayOf[Integer, nil?: true].to_sorbet_type
        puts OpenAI::Internal::Type::HashOf[Integer].to_sorbet_type
        puts OpenAI::Internal::Type::HashOf[Integer, nil?: true].to_sorbet_type
      RUBY
    )

    assert_predicate(status, :success?, stderr)
    assert_equal(
      <<~OUTPUT,
        T::Array[Integer]
        T::Array[T.nilable(Integer)]
        T::Hash[Symbol, Integer]
        T::Hash[Symbol, T.nilable(Integer)]
      OUTPUT
      stdout
    )
  end

  def test_generated_collection_contracts_have_runtime_sorbet_types
    stdout, stderr, status = Open3.capture3(
      {"RUBYOPT" => nil},
      RbConfig.ruby,
      "-I",
      File.expand_path("../../../../lib", __dir__),
      "-rsorbet-runtime",
      "-ropenai",
      "-e",
      <<~RUBY
        puts OpenAI::Models::Metadata.to_sorbet_type
        puts OpenAI::Models::CompletionCreateParams::Prompt::Variants
      RUBY
    )

    assert_predicate(status, :success?, stderr)
    assert_equal(
      <<~OUTPUT,
        T::Hash[Symbol, String]
        T.any(String, T::Array[Integer], T::Array[String], T::Array[T::Array[Integer]])
      OUTPUT
      stdout
    )
  end
end
