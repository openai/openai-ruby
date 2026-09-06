# frozen_string_literal: true

require "fileutils"
require "open3"
require "tempfile"
require "tmpdir"

require_relative "../test_helper"

class OpenAI::Test::ChatStreamErrorTypesTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class SyntheticAnswer < OpenAI::BaseModel
    required :answer, Integer
  end

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_public_chat_stream_raises_existing_finish_errors
    length_error = assert_raises(OpenAI::LengthFinishReasonError) do
      stream_for("length").get_final_completion
    end

    assert_kind_of(OpenAI::Helpers::Streaming::StreamError, length_error)
    assert_instance_of(OpenAI::Models::Chat::ParsedChatCompletion, length_error.completion)
    assert_equal(:length, length_error.completion.choices.first.finish_reason)

    content_filter_error = assert_raises(OpenAI::ContentFilterFinishReasonError) do
      stream_for("content_filter").get_final_completion
    end

    assert_kind_of(OpenAI::Helpers::Streaming::StreamError, content_filter_error)
    assert_instance_of(
      OpenAI::ContentFilterFinishReasonError,
      OpenAI::ContentFilterFinishReasonError.new
    )
    assert_raises(ArgumentError) { OpenAI::ContentFilterFinishReasonError.new("message") }
  end

  def test_shipped_rbi_types_public_finish_error_rescues_and_completion
    stdout, stderr, status = sorbet_typecheck(sorbet_source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbs_types_public_finish_error_rescues_and_completion
    stdout, stderr, status = steep_check(rbs_source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_rejects_content_filter_error_message_constructor
    source = sorbet_source.sub(
      "OpenAI::ContentFilterFinishReasonError.new",
      "OpenAI::ContentFilterFinishReasonError.new(\"message\")"
    )
    stdout, stderr, status = sorbet_typecheck(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "Too many arguments")
  end

  def test_shipped_rbs_rejects_content_filter_error_message_constructor
    source = rbs_source.sub(
      "OpenAI::ContentFilterFinishReasonError.new",
      "OpenAI::ContentFilterFinishReasonError.new(\"message\")"
    )
    stdout, stderr, status = steep_check(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "Unexpected positional argument")
  end

  private

  def stream_for(finish_reason)
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: stream_body(finish_reason)
      )

    OpenAI::Client
      .new(base_url: "http://localhost", api_key: "synthetic-key")
      .chat
      .completions
      .stream(
        model: "gpt-4o-mini",
        messages: [{role: :user, content: "Synthetic"}],
        response_format: SyntheticAnswer
      )
  end

  def stream_body(finish_reason)
    payload = {
      id: "chatcmpl-synthetic-finish",
      object: "chat.completion.chunk",
      created: 1,
      model: "gpt-4o-mini",
      choices: [
        {
          index: 0,
          delta: {role: "assistant", content: "{\"answer\":"},
          finish_reason: finish_reason
        }
      ]
    }

    "data: #{JSON.generate(payload)}\n\ndata: [DONE]\n\n"
  end

  def sorbet_source
    <<~RUBY
      # typed: strict

      completion = T.let(T.unsafe(nil), OpenAI::Chat::ParsedChatCompletion)
      built = OpenAI::LengthFinishReasonError.new(completion: completion)
      T.assert_type!(built, OpenAI::Helpers::Streaming::LengthFinishReasonError)
      T.assert_type!(built.completion, OpenAI::Chat::ParsedChatCompletion)
      content_filter = OpenAI::ContentFilterFinishReasonError.new
      T.assert_type!(content_filter, OpenAI::Helpers::Streaming::ContentFilterFinishReasonError)

      begin
        raise built
      rescue OpenAI::LengthFinishReasonError => error
        T.assert_type!(error, OpenAI::Helpers::Streaming::LengthFinishReasonError)
        T.assert_type!(error.completion, OpenAI::Chat::ParsedChatCompletion)
      rescue OpenAI::ContentFilterFinishReasonError => error
        T.assert_type!(error, OpenAI::Helpers::Streaming::ContentFilterFinishReasonError)
      end
    RUBY
  end

  def rbs_source
    <<~RUBY
      # @type var inspect_finish_error: ^(OpenAI::Models::Chat::ChatCompletion) -> OpenAI::Helpers::Streaming::StreamError
      inspect_finish_error = ->(completion) do
        error = OpenAI::LengthFinishReasonError.new(completion: completion)
        error.completion.id
        content_filter = OpenAI::ContentFilterFinishReasonError.new
        content_filter.class

        begin
          raise error
        rescue OpenAI::LengthFinishReasonError => length_error
          length_error.completion.id
          length_error
        rescue OpenAI::ContentFilterFinishReasonError => content_filter_error
          content_filter_error
        end
      end

      inspect_finish_error
    RUBY
  end

  def sorbet_typecheck(source)
    root = File.expand_path("../../..", __dir__)

    Tempfile.create(["chat-stream-error-sorbet", ".rb"]) do |file|
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

  def steep_check(source)
    root = File.expand_path("../../..", __dir__)

    Dir.mktmpdir("chat-stream-error-rbs") do |directory|
      FileUtils.cp_r(File.join(root, "sig"), directory)
      File.write(File.join(directory, "probe.rb"), source)
      File.write(
        File.join(directory, "Steepfile"),
        <<~RUBY
          target :lib do
            signature "sig"
            library "net-http"
            check "probe.rb"
          end
        RUBY
      )
      Open3.capture3(
        "steep",
        "check",
        "--no-daemon",
        "--jobs=1",
        "--validate=skip",
        chdir: directory
      )
    end
  end
end
