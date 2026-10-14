# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "test_helper"

class OpenAI::Test::HashSorbetCompatibilityTest < Minitest::Test
  extend Minitest::Serial

  def test_request_parameter_keyword_splat
    stdout, stderr, status = typecheck(
      <<~RUBY
        # typed: strict
        client = OpenAI::Client.new(api_key: "synthetic-key")
        params = OpenAI::Models::Chat::CompletionCreateParams.new(
          messages: [OpenAI::Models::ChatCompletionUserMessageParam.new(content: "Synthetic")],
          model: "gpt-4"
        )
        client.chat.completions.create(**params)
      RUBY
    )
    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_response_model_constructor_keyword_splat
    stdout, stderr, status = typecheck(
      <<~RUBY
        # typed: strict
        item = OpenAI::Responses::ResponseOutputItem::ImageGenerationCall.new(
          id: "img_synthetic", status: :failed, result: nil
        )
        OpenAI::Responses::ResponseOutputItem::ImageGenerationCall.new(**item)
      RUBY
    )
    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_required_field_types_remain_checked
    stdout, stderr, status = typecheck(
      <<~RUBY
        # typed: strict
        OpenAI::Responses::ResponseOutputItem::ImageGenerationCall.new(
          id: 123, status: :failed, result: nil
        )
      RUBY
    )
    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "argument `id`")
  end

  private def typecheck(source)
    root = File.expand_path("../..", __dir__)
    Tempfile.create(["hash-sorbet-compatibility", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
    end
  end
end
