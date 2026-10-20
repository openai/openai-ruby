# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::ChatToolInputTypesTest < Minitest::Test
  def test_converters_remain_supported_by_create_and_high_level_stream
    stdout, stderr, status = typecheck(
      <<~RUBY
        client.chat.completions.create(model: "gpt-4o-mini", messages: [], tools: [LookupTool])
        client.chat.completions.stream(model: "gpt-4o-mini", messages: [], tools: [LookupTool])
        result = client.chat.completions.run_tools(
          model: "gpt-4o-mini", messages: [], tools: [LookupTool],
          tool_handlers: {"LookupTool" => -> (arguments) { arguments.fetch("query") }}, max_rounds: 3
        )
        T.assert_type!(result, OpenAI::Chat::ChatCompletion)
        client.chat.completions.stream_raw(
          model: "gpt-4o-mini",
          messages: [],
          tools: [{type: :function, function: {name: "lookup", parameters: {type: "object"}}}]
        )
      RUBY
    )

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_raw_stream_rejects_converter_classes
    stdout, stderr, status = typecheck(
      <<~RUBY
        client.chat.completions.stream_raw(model: "gpt-4o-mini", messages: [], tools: [LookupTool])
      RUBY
    )

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "Expected")
    assert_includes("#{stdout}\n#{stderr}", "tools")
    assert_includes("#{stdout}\n#{stderr}", "T.class_of(LookupTool)")
  end

  private

  def typecheck(calls)
    root = File.expand_path("../../..", __dir__)
    source = <<~RUBY
      # typed: strict

      class LookupTool < OpenAI::BaseModel
        required :query, String
      end

      client = OpenAI::Client.new(api_key: "synthetic-key")
      #{calls}
    RUBY

    Tempfile.create(["chat-tool-input-types", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "typecheck",
        file.path,
        chdir: root
      )
    end
  end
end
