# frozen_string_literal: true

require "open3"
require_relative "../test_helper"
require_relative "../../../examples/realtime/mcp_approval"
require_relative "../../../examples/realtime/realtime_conversation"
require_relative "../../../examples/realtime/sideband"
require_relative "../../../examples/realtime/sip"
require_relative "../../../examples/realtime/webrtc_conversation"
require_relative "../../../examples/realtime/websocket_text"

class OpenAI::Test::RealtimeExamplesTest < Minitest::Test
  Event = Data.define(:type, :data) do
    def to_h = data
  end

  class RecordingSession
    attr_reader :updates

    def initialize
      @updates = []
    end

    def update(**params)
      @updates << params
    end
  end

  class RecordingResource
    attr_reader :calls, :truncations

    def initialize(writer_fibers = nil)
      @calls = []
      @truncations = []
      @writer_fibers = writer_fibers
    end

    def create(**params)
      @calls << params
    end

    def truncate(**params)
      @writer_fibers&.push(Fiber.current)
      @truncations << params
    end
  end

  class RecordingConversation
    attr_reader :items

    def initialize(writer_fibers = nil)
      @items = RecordingResource.new(writer_fibers)
    end
  end

  class RecordingAudioBuffer
    attr_accessor :append_error
    attr_reader :chunks

    def initialize(writer_fibers = nil)
      @chunks = []
      @writer_fibers = writer_fibers
    end

    def append_bytes(bytes)
      @writer_fibers&.push(Fiber.current)
      raise @append_error if @append_error

      @chunks << bytes
    end
  end

  class RecordingOutbound
    attr_reader :chunks, :truncations

    def initialize
      @chunks = []
      @truncations = []
    end

    def append_audio(bytes) = @chunks << bytes
    def truncate(**params) = @truncations << params
  end

  class RecordingConnection
    attr_reader :conversation, :input_audio_buffer, :response, :session, :writer_fibers

    def initialize(events = [])
      @events = events
      @writer_fibers = []
      @session = RecordingSession.new
      @conversation = RecordingConversation.new(@writer_fibers)
      @input_audio_buffer = RecordingAudioBuffer.new(@writer_fibers)
      @response = RecordingResource.new
    end

    def each(&block)
      @events.each(&block)
    end

    def receive
      @events.shift
    end
  end

  class ExplodingConnection < RecordingConnection
    def each
      raise "sideband failed"
    end
  end

  class RecordingCalls
    attr_accessor :hangup_error
    attr_reader :accepts, :hangups

    def initialize
      @accepts = []
      @hangups = []
    end

    def accept(call_id, **params)
      @accepts << [call_id, params]
    end

    def hangup(call_id)
      @hangups << call_id
      raise @hangup_error if @hangup_error
    end
  end

  class RecordingRealtime
    attr_reader :calls, :connections

    def initialize(connection)
      @calls = RecordingCalls.new
      @connection = connection
      @connections = []
    end

    def connect(call_id:)
      @connections << call_id
      yield(@connection)
    end
  end

  RecordingClient = Data.define(:realtime)

  HTTPRequest = Data.define(:request_method, :path, :body, :headers) do
    def [](name) = headers[name.downcase]
  end

  class HTTPResponse
    attr_accessor :body, :status
    attr_reader :headers

    def initialize
      @headers = {}
    end

    def []=(name, value)
      @headers[name] = value
    end
  end

  class RecordingWebRTCCalls
    attr_accessor :hangup_error
    attr_reader :creates, :hangups

    def initialize
      @creates = []
      @hangups = []
    end

    def create(**params)
      @creates << params
      OpenAI::Realtime::CallCreateResponse.new(
        sdp: "answer-sdp",
        call_id: "rtc_example",
        headers: {}
      )
    end

    def hangup(call_id)
      @hangups << call_id
      raise @hangup_error if @hangup_error
    end
  end

  class RecordingMicrophone
    attr_reader :stopped

    def initialize(chunks)
      @chunks = chunks
      @stopped = false
    end

    def each_chunk(&block)
      @chunks.each(&block)
    end

    def stop = @stopped = true
  end

  class RecordingSpeaker
    attr_reader :audio, :interruptions

    def initialize
      @audio = +"".b
      @interruptions = 0
    end

    def write(bytes)
      @audio << bytes
    end

    def interrupt
      @interruptions += 1
    end

    def close = nil
  end

  def test_realtime_conversation_configures_continuous_server_vad
    connection = RecordingConnection.new

    OpenAI::Examples::Realtime::Conversation.configure(
      connection,
      voice: :marin,
      instructions: "Speak naturally."
    )

    assert_equal(
      {
        type: :realtime,
        output_modalities: [:audio],
        instructions: "Speak naturally.",
        audio: {
          input: {
            format: {type: :"audio/pcm", rate: 24_000},
            noise_reduction: {type: :near_field},
            turn_detection: {
              type: :server_vad,
              threshold: 0.5,
              prefix_padding_ms: 300,
              silence_duration_ms: 500,
              create_response: true,
              interrupt_response: true
            }
          },
          output: {
            format: {type: :"audio/pcm", rate: 24_000},
            voice: :marin
          }
        }
      },
      connection.session.updates.fetch(0)
    )
  end

  def test_realtime_conversation_streams_microphone_chunks_without_committing
    outbound = RecordingOutbound.new
    microphone = RecordingMicrophone.new(["first".b, "second".b])

    OpenAI::Examples::Realtime::Conversation.forward_microphone(outbound, microphone)

    assert_equal(["first".b, "second".b], outbound.chunks)
  end

  def test_realtime_conversation_serializes_audio_and_interruptions_through_one_writer
    connection = RecordingConnection.new
    outbound = OpenAI::Examples::Realtime::Conversation::OutboundWriter.new(connection)

    Sync do |task|
      writer = task.async { outbound.run }
      outbound.append_audio("first".b)
      outbound.truncate(item_id: "item_1", content_index: 0, audio_end_ms: 100)
      outbound.append_audio("second".b)
      outbound.close
      writer.wait
    end

    assert_equal(["first".b, "second".b], connection.input_audio_buffer.chunks)
    assert_equal(
      [{item_id: "item_1", content_index: 0, audio_end_ms: 100}],
      connection.conversation.items.truncations
    )
    assert_equal(1, connection.writer_fibers.uniq.size)
  end

  def test_realtime_conversation_unblocks_a_producer_when_the_writer_fails
    connection = RecordingConnection.new
    connection.input_audio_buffer.append_error = RuntimeError.new("write failed")
    outbound = OpenAI::Examples::Realtime::Conversation::OutboundWriter.new(connection)

    error = Sync do |task|
      writer = task.async do
        outbound.run
        nil
      rescue StandardError => e
        e
      end
      outbound.append_audio("first".b)
      producer_error = assert_raises(RuntimeError) do
        outbound.append_audio("second".b)
      end
      writer_error = writer.wait

      assert_same(writer_error, producer_error)
      producer_error
    end

    assert_equal("write failed", error.message)
  end

  def test_realtime_conversation_handles_initial_speech_before_assistant_audio
    speaker = RecordingSpeaker.new
    outbound = RecordingOutbound.new
    playback = OpenAI::Examples::Realtime::Conversation::AudioPlayback.new(
      speaker,
      clock: -> { raise "clock must not be read without playback" }
    )

    playback.interrupt(outbound)

    assert_empty(outbound.truncations)
    assert_equal(1, speaker.interruptions)
  end

  def test_realtime_conversation_propagates_writer_failure_without_deadlock
    connection = RecordingConnection.new(
      [OpenAI::Realtime::SessionUpdatedEvent.new(event_id: "event_1", session: {})]
    )
    connection.input_audio_buffer.append_error = RuntimeError.new("write failed")
    microphone = RecordingMicrophone.new(["first".b, "second".b])

    error = Sync do
      assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::Conversation.run_session(
          connection,
          microphone: microphone,
          speaker: RecordingSpeaker.new,
          voice: :marin,
          instructions: "Speak naturally.",
          output: StringIO.new
        )
      end
    end

    assert_equal("write failed", error.message)
    assert_predicate(microphone, :stopped)
  end

  def test_realtime_conversation_streams_audio_and_interrupts_local_playback
    speaker = RecordingSpeaker.new
    times = [0.0, 0.1].each
    playback = OpenAI::Examples::Realtime::Conversation::AudioPlayback.new(
      speaker,
      clock: -> { times.next }
    )
    output = StringIO.new
    outbound = RecordingOutbound.new
    audio = "\x00\x01".b * 2_400
    event_fields = {
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0
    }

    OpenAI::Examples::Realtime::Conversation.handle_event(
      OpenAI::Realtime::ResponseAudioDeltaEvent.new(**event_fields, delta: Base64.strict_encode64(audio)),
      outbound: outbound,
      playback: playback,
      output: output
    )
    OpenAI::Examples::Realtime::Conversation.handle_event(
      OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent.new(**event_fields, delta: "Hello"),
      outbound: outbound,
      playback: playback,
      output: output
    )
    OpenAI::Examples::Realtime::Conversation.handle_event(
      OpenAI::Realtime::InputAudioBufferSpeechStartedEvent.new(
        event_id: "event_2",
        item_id: "item_2",
        audio_start_ms: 100
      ),
      outbound: outbound,
      playback: playback,
      output: output
    )

    assert_equal(audio, speaker.audio)
    assert_equal("Hello\n", output.string)
    assert_equal(1, speaker.interruptions)
    assert_equal(
      [{item_id: "item_1", content_index: 0, audio_end_ms: 100}],
      outbound.truncations
    )
  end

  def test_realtime_conversation_drops_queued_audio_after_interruption
    speaker = RecordingSpeaker.new
    times = [0.0, 0.05].each
    playback = OpenAI::Examples::Realtime::Conversation::AudioPlayback.new(
      speaker,
      clock: -> { times.next }
    )
    output = StringIO.new
    outbound = RecordingOutbound.new
    event_fields = {
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0
    }
    first_audio = "\x00\x01".b * 2_400
    queued_audio = "\x02\x03".b * 2_400

    playback.write(
      OpenAI::Realtime::ResponseAudioDeltaEvent.new(
        **event_fields,
        delta: Base64.strict_encode64(first_audio)
      )
    )
    OpenAI::Examples::Realtime::Conversation.handle_event(
      OpenAI::Realtime::InputAudioBufferSpeechStartedEvent.new(
        event_id: "event_2",
        item_id: "item_2",
        audio_start_ms: 50
      ),
      outbound: outbound,
      playback: playback,
      output: output
    )
    playback.write(
      OpenAI::Realtime::ResponseAudioDeltaEvent.new(
        **event_fields,
        event_id: "event_3",
        delta: Base64.strict_encode64(queued_audio)
      )
    )
    OpenAI::Examples::Realtime::Conversation.handle_event(
      OpenAI::Realtime::ResponseDoneEvent.new(
        event_id: "event_4",
        response: OpenAI::Realtime::RealtimeResponse.new(id: "response_1", status: :cancelled)
      ),
      outbound: outbound,
      playback: playback,
      output: output
    )

    assert_equal(first_audio, speaker.audio)
    assert_equal("\n", output.string)
    assert_equal(1, speaker.interruptions)
  end

  def test_realtime_conversation_does_not_truncate_fully_played_completed_audio
    speaker = RecordingSpeaker.new
    outbound = RecordingOutbound.new
    times = [0.0, 0.05, 0.2].each
    playback = OpenAI::Examples::Realtime::Conversation::AudioPlayback.new(
      speaker,
      clock: -> { times.next }
    )
    fields = {
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0
    }
    audio = "\x00\x01".b * 2_400

    playback.write(
      OpenAI::Realtime::ResponseAudioDeltaEvent.new(
        **fields,
        delta: Base64.strict_encode64(audio)
      )
    )
    playback.finish("response_1")
    playback.interrupt(outbound)

    assert_empty(outbound.truncations)
    assert_equal(1, speaker.interruptions)
  end

  def test_realtime_conversation_can_capture_output_audio_for_a_live_smoke_test
    Tempfile.create(["realtime-conversation", ".pcm"]) do |file|
      speaker = OpenAI::Examples::Realtime::Conversation::PCMFileSpeaker.new(file.path)

      speaker.write("\x00\x01".b)
      speaker.interrupt
      speaker.write("\x02\x03".b)
      speaker.close

      assert_equal("\x00\x01\x02\x03".b, File.binread(file.path))
    end
  end

  def test_realtime_conversation_uses_ffplays_input_channel_layout_option
    speaker_class = Class.new(OpenAI::Examples::Realtime::Conversation::FFplaySpeaker) do
      def playback_command = command
    end
    command = speaker_class.new.playback_command

    assert_equal(["-ch_layout", "mono"], command.slice(command.index("-ch_layout"), 2))
    refute_includes(command, "-ac")
  end

  def test_realtime_conversation_ffplay_command_accepts_raw_pcm
    speaker_class = Class.new(OpenAI::Examples::Realtime::Conversation::FFplaySpeaker) do
      def playback_command = command
    end
    command = speaker_class.new.playback_command
    command.insert(command.index("-i"), "-autoexit")

    _, stderr, status = Open3.capture3(
      {"SDL_AUDIODRIVER" => "dummy"},
      *command,
      stdin_data: "\0".b * 4_800
    )

    assert_predicate(status, :success?, stderr)
    assert_empty(stderr, "ffplay must not emit terminal control sequences")
  rescue Errno::ENOENT
    skip("ffplay is not installed")
  end

  def test_webrtc_conversation_serves_a_browser_peer_with_audio_processing
    calls = RecordingWebRTCCalls.new
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(Data.define(:calls).new(calls))
    )
    response = HTTPResponse.new

    app.handle(
      HTTPRequest.new(
        request_method: "GET",
        path: "/",
        body: "",
        headers: {}
      ),
      response
    )

    assert_equal(200, response.status)
    assert_equal("text/html; charset=utf-8", response.headers.fetch("Content-Type"))
    assert_includes(response.body, "new RTCPeerConnection()")
    assert_includes(response.body, "echoCancellation: true")
    assert_includes(response.body, "noiseSuppression: true")
    assert_includes(response.body, "autoGainControl: true")
    refute_includes(response.body, "OPENAI_API_KEY")
  end

  def test_webrtc_conversation_negotiates_and_hangs_up_through_ruby
    calls = RecordingWebRTCCalls.new
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(Data.define(:calls).new(calls)),
      html: "test"
    )
    response = HTTPResponse.new

    app.handle(
      HTTPRequest.new(
        request_method: "POST",
        path: "/session",
        body: "v=0\r\nt=0 0\r\n",
        headers: {"content-type" => "application/sdp"}
      ),
      response
    )

    assert_equal(201, response.status)
    assert_equal("answer-sdp", response.body)
    assert_equal("rtc_example", response.headers.fetch("X-OpenAI-Call-ID"))
    assert_equal("v=0\r\nt=0 0\r\n", calls.creates.fetch(0).fetch(:sdp))
    session = calls.creates.fetch(0).fetch(:session)
    assert_equal("gpt-realtime-2.1", session.fetch(:model))
    assert_equal(true, session.dig(:audio, :input, :turn_detection, :interrupt_response))

    hangup_response = HTTPResponse.new
    app.handle(
      HTTPRequest.new(
        request_method: "POST",
        path: "/hangup",
        body: "rtc_example",
        headers: {}
      ),
      hangup_response
    )

    assert_equal(204, hangup_response.status)
    assert_equal(["rtc_example"], calls.hangups)
  end

  def test_webrtc_conversation_rejects_non_sdp_requests
    calls = RecordingWebRTCCalls.new
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(Data.define(:calls).new(calls)),
      html: "test"
    )
    response = HTTPResponse.new

    app.handle(
      HTTPRequest.new(
        request_method: "POST",
        path: "/session",
        body: "not sdp",
        headers: {"content-type" => "text/plain"}
      ),
      response
    )

    assert_equal(400, response.status)
    assert_empty(calls.creates)
  end

  def test_webrtc_conversation_treats_an_already_closed_call_as_hung_up
    calls = RecordingWebRTCCalls.new
    calls.hangup_error = OpenAI::Errors::NotFoundError.new(
      url: URI("https://api.openai.com/v1/realtime/calls/rtc_example/hangup"),
      status: 404,
      headers: {},
      body: {},
      request: nil,
      response: nil
    )
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(Data.define(:calls).new(calls)),
      html: "test"
    )
    app.handle(
      HTTPRequest.new(
        request_method: "POST",
        path: "/session",
        body: "v=0\r\nt=0 0\r\n",
        headers: {"content-type" => "application/sdp"}
      ),
      HTTPResponse.new
    )
    response = HTTPResponse.new

    app.handle(
      HTTPRequest.new(
        request_method: "POST",
        path: "/hangup",
        body: "rtc_example",
        headers: {}
      ),
      response
    )

    assert_equal(204, response.status)
    assert_equal(["rtc_example"], calls.hangups)
  end

  def test_mcp_console_example_requests_text_output
    connection = RecordingConnection.new

    OpenAI::Examples::Realtime::MCPApproval.configure(
      connection,
      server_url: "https://developers.openai.com/mcp"
    )

    session = connection.session.updates.fetch(0)
    assert_equal([:text], session.fetch(:output_modalities))
    refute(session.key?(:tool_choice))
  end

  def test_mcp_console_example_requires_the_discovered_tool
    tools_item = OpenAI::Realtime::RealtimeMcpListTools.new(
      id: "mcp_tools_1",
      server_label: "remote",
      tools: [
        OpenAI::Realtime::RealtimeMcpListTools::Tool.new(
          name: "search_openai_docs",
          description: "Search the OpenAI developer documentation",
          input_schema: {type: "object"}
        )
      ]
    )
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ConversationItemDone.new(
          event_id: "event_1",
          item: tools_item
        ),
        OpenAI::Realtime::McpListToolsCompleted.new(
          event_id: "event_2",
          item_id: "mcp_tools_1"
        ),
        OpenAI::Realtime::SessionUpdatedEvent.new(
          event_id: "event_3",
          session: {}
        ),
        completed_response_event
      ]
    )

    OpenAI::Examples::Realtime::MCPApproval.run_session(
      connection,
      prompt: "Search the docs",
      output: StringIO.new
    )

    assert_equal(
      {
        type: :realtime,
        tools: [{type: :mcp, server_label: "remote"}],
        tool_choice: {type: :mcp, server_label: "remote", name: "search_openai_docs"}
      },
      connection.session.updates.fetch(0)
    )
    assert_equal({}, connection.response.calls.fetch(0))
  end

  def test_mcp_console_example_waits_for_the_tool_choice_update
    tools_item = OpenAI::Realtime::RealtimeMcpListTools.new(
      id: "mcp_tools_1",
      server_label: "remote",
      tools: [
        OpenAI::Realtime::RealtimeMcpListTools::Tool.new(
          name: "search_openai_docs",
          input_schema: {type: "object"}
        )
      ]
    )
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ConversationItemDone.new(event_id: "event_1", item: tools_item),
        OpenAI::Realtime::McpListToolsCompleted.new(event_id: "event_2", item_id: "mcp_tools_1")
      ]
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::MCPApproval.run_session(
        connection,
        prompt: "Search the docs",
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before the final response.done", error.message)
    assert_empty(connection.response.calls)
    assert_empty(connection.conversation.items.calls)
  end

  def test_mcp_console_example_requests_a_final_answer_after_the_tool_completes
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseMcpCallCompleted.new(
          event_id: "event_1",
          item_id: "mcp_call_1",
          output_index: 0
        ),
        completed_response_event
      ]
    )

    OpenAI::Examples::Realtime::MCPApproval.run_session(
      connection,
      prompt: "Search the docs",
      output: StringIO.new
    )

    assert_equal({tool_choice: :none}, connection.response.calls.fetch(0))
  end

  def test_sideband_smoke_mode_stops_after_the_selected_event
    events = [
      Event.new(type: :"session.updated", data: {type: :"session.updated"}),
      Event.new(type: :"response.done", data: {type: :"response.done"})
    ]
    connection = RecordingConnection.new(events)
    output = StringIO.new

    OpenAI::Examples::Realtime::Sideband.stream(
      connection,
      output: output,
      stop_after: "session.updated"
    )

    assert_includes(output.string, "session.updated")
    refute_includes(output.string, "response.done")
  end

  def test_sip_example_accepts_then_attaches_to_the_call
    connection = RecordingConnection.new(
      [Event.new(type: :"session.created", data: {type: :"session.created"})]
    )
    realtime = RecordingRealtime.new(connection)

    OpenAI::Examples::Realtime::SIP.run(
      client: RecordingClient.new(realtime: realtime),
      call_id: "rtc_123",
      model: "gpt-realtime-2.1",
      output: StringIO.new,
      stop_after: "session.created"
    )

    assert_equal(["rtc_123"], realtime.connections)
    assert_equal(
      [
        "rtc_123",
        {
          type: :realtime,
          model: "gpt-realtime-2.1",
          instructions: "You are answering a phone call. Be warm and concise."
        }
      ],
      realtime.calls.accepts.fetch(0)
    )
    assert_equal(["rtc_123"], realtime.calls.hangups)
  end

  def test_sip_example_hangs_up_without_masking_a_sideband_error
    realtime = RecordingRealtime.new(ExplodingConnection.new)
    realtime.calls.hangup_error = RuntimeError.new("hangup failed")

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::SIP.run(
        client: RecordingClient.new(realtime: realtime),
        call_id: "rtc_123",
        model: "gpt-realtime-2.1",
        output: StringIO.new
      )
    end

    assert_equal("sideband failed", error.message)
    assert_equal(["rtc_123"], realtime.calls.hangups)
  end

  def test_sip_example_tolerates_an_already_ended_call_during_cleanup
    realtime = RecordingRealtime.new(RecordingConnection.new)
    realtime.calls.hangup_error = OpenAI::Errors::NotFoundError.new(
      url: URI("https://api.openai.com/v1/realtime/calls/rtc_123/hangup"),
      status: 404,
      headers: {},
      body: {},
      request: nil,
      response: nil
    )

    OpenAI::Examples::Realtime::SIP.run(
      client: RecordingClient.new(realtime: realtime),
      call_id: "rtc_123",
      model: "gpt-realtime-2.1",
      output: StringIO.new
    )

    assert_equal(["rtc_123"], realtime.calls.hangups)
  end

  def test_sip_example_reports_a_cleanup_failure_after_a_clean_session
    realtime = RecordingRealtime.new(RecordingConnection.new)
    realtime.calls.hangup_error = RuntimeError.new("hangup failed")

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::SIP.run(
        client: RecordingClient.new(realtime: realtime),
        call_id: "rtc_123",
        model: "gpt-realtime-2.1",
        output: StringIO.new
      )
    end

    assert_equal("hangup failed", error.message)
    assert_equal(["rtc_123"], realtime.calls.hangups)
  end

  def test_websocket_text_rejects_a_connection_that_closes_before_response_done
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketText.stream_response(
        RecordingConnection.new,
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before response.done", error.message)
  end

  def test_websocket_text_accepts_only_a_completed_response
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseDoneEvent.new(
          event_id: "event_1",
          response: OpenAI::Realtime::RealtimeResponse.new(
            id: "response_1",
            status: :completed
          )
        )
      ]
    )
    output = StringIO.new

    OpenAI::Examples::Realtime::WebSocketText.stream_response(connection, output: output)

    assert_includes(output.string, "response.done status=completed")
  end

  private def completed_response_event
    OpenAI::Realtime::ResponseDoneEvent.new(
      event_id: "event_done",
      response: OpenAI::Realtime::RealtimeResponse.new(
        id: "response_done",
        status: :completed
      )
    )
  end
end
