# frozen_string_literal: true

require "fileutils"
require "open3"
require "pathname"
require "rbs"
require "tmpdir"

require_relative "../test_helper"

class OpenAI::Test::ResponseStreamRBSTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  ROOT = Pathname(__dir__).join("../../..").expand_path
  STREAM_EVENT = "OpenAI::Models::Responses::response_stream_event"
  UNKNOWN_EVENT = "OpenAI::Helpers::Streaming::UnknownStreamEvent"

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_shipped_rbs_resolves_high_level_response_stream_contract
    responses = definition("::OpenAI::Resources::Responses")
    stream = responses.methods.fetch(:stream)
    stream_raw = responses.methods.fetch(:stream_raw)

    assert_equal(
      ["::OpenAI::Helpers::Streaming::ResponseStream"],
      return_types(stream)
    )
    assert_equal(
      ["::OpenAI::Internal::Stream[::#{STREAM_EVENT} | ::#{UNKNOWN_EVENT}]"],
      return_types(stream_raw)
    )

    response_stream = definition("::OpenAI::Streaming::ResponseStream")
    initialize_types = response_stream.methods.fetch(:initialize).method_types.map(&:to_s)
    assert_equal(1, initialize_types.size)
    assert_includes(initialize_types.fetch(0), "raw_stream:")
    refute_includes(initialize_types.fetch(0), "model:")
    assert_equal(["self"], return_types(response_stream.methods.fetch(:until_done)))
    assert_equal(
      ["::Enumerator[::String]"],
      return_types(response_stream.methods.fetch(:text))
    )
    assert_equal(
      ["::OpenAI::Models::Responses::Response"],
      return_types(response_stream.methods.fetch(:get_final_response))
    )
    assert_equal(["::String"], return_types(response_stream.methods.fetch(:get_output_text)))
    assert(response_stream.methods.key?(:each), "stream mixin should expose #each")
    assert(response_stream.methods.key?(:close), "stream mixin should expose #close")
    each_types = response_stream.methods.fetch(:each).method_types.map(&:to_s)
    assert_includes(each_types.join, "::OpenAI::Helpers::Streaming::response_stream_event")

    passthrough = type_alias("::OpenAI::Helpers::Streaming::response_stream_passthrough_event")
    assert_includes(passthrough, "::OpenAI::Models::Responses::ResponseAudioDeltaEvent")
    refute_includes(passthrough, "::OpenAI::Models::Responses::ResponseTextDeltaEvent")
    refute_includes(passthrough, "::OpenAI::Models::Responses::ResponseTextDoneEvent")
    refute_includes(passthrough, "::OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent")
    refute_includes(passthrough, "::OpenAI::Models::Responses::ResponseCompletedEvent")
  end

  def test_shipped_rbs_type_checks_enhanced_response_events
    source = <<~RUBY
      stream = OpenAI::Client.new(api_key: "test-key").responses.stream(
        model: "gpt-4o-mini",
        input: "synthetic"
      )
      stream.each do |event|
        case event
        when OpenAI::Streaming::ResponseTextDeltaEvent
          event.snapshot
        when OpenAI::Streaming::ResponseTextDoneEvent
          event.parsed
        when OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent
          event.snapshot
        when OpenAI::Streaming::ResponseCompletedEvent
          event.response
        end
      end
    RUBY

    stdout, stderr, status = steep_check(source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_public_response_stream_runtime_supports_declared_helpers
    stub_request(:post, "http://localhost/responses")
      .with(body: hash_including(model: "gpt-4o-mini", input: "synthetic", stream: true))
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: synthetic_text_stream
      )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "test-key"
    )
    stream = client.responses.stream(model: "gpt-4o-mini", input: "synthetic")

    assert_instance_of(OpenAI::Helpers::Streaming::ResponseStream, stream)
    text = stream.text
    assert_instance_of(Enumerator, text)
    assert_equal("hello", text.next)

    stream = client.responses.stream(model: "gpt-4o-mini", input: "synthetic")
    assert_same(stream, stream.until_done)
    assert_equal("hello", stream.get_output_text)
    assert_equal("resp_synthetic", stream.get_final_response.id)
  end

  private

  def definition(type_name)
    RBS::DefinitionBuilder.new(env: environment).build_instance(RBS::TypeName.parse(type_name))
  end

  def type_alias(type_name)
    environment.type_alias_decls.fetch(RBS::TypeName.parse(type_name)).decl.type.to_s
  end

  def environment
    loader = RBS::EnvironmentLoader.new
    loader.add(path: ROOT.join("sig"))
    loader.add(library: "net-http")
    RBS::Environment.from_loader(loader).resolve_type_names
  end

  def return_types(method)
    method.method_types.map { |method_type| method_type.type.return_type.to_s }
  end

  def steep_check(source)
    Dir.mktmpdir("response-stream-rbs") do |directory|
      FileUtils.cp_r(ROOT.join("sig"), directory)
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

  def synthetic_text_stream
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"resp_synthetic","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"resp_synthetic","output_index":0,"item":{"id":"item_synthetic","object":"realtime.item","type":"message","status":"in_progress","role":"assistant","content":[]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"resp_synthetic","item_id":"item_synthetic","output_index":0,"content_index":0,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":4,"response_id":"resp_synthetic","item_id":"item_synthetic","output_index":0,"content_index":0,"delta":"hello"}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":5,"response_id":"resp_synthetic","item_id":"item_synthetic","output_index":0,"content_index":0,"text":"hello"}

      event: response.completed
      data: {"type":"response.completed","sequence_number":6,"response":{"id":"resp_synthetic","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_synthetic","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"hello"}]}],"usage":{"total_tokens":2,"input_tokens":1,"output_tokens":1},"metadata":null}}

    SSE
  end
end
