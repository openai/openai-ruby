# frozen_string_literal: true

require "open3"
require_relative "examples_test_case"
require_relative "../../../examples/realtime/mcp_approval"
require_relative "../../../examples/realtime/realtime_conversation"
require_relative "../../../examples/realtime/sideband"
require_relative "../../../examples/realtime/sip"
require_relative "../../../examples/realtime/webrtc_conversation"
require_relative "../../../examples/realtime/websocket_audio"

class OpenAI::Test::RealtimeExamplesTest < OpenAI::Test::RealtimeExamplesTestCase
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

  def test_realtime_conversation_latches_stop_before_ffmpeg_capture_starts
    connection = RecordingConnection.new(
      [OpenAI::Realtime::SessionUpdatedEvent.new(event_id: "event_1", session: {})]
    )
    microphone = OpenAI::Examples::Realtime::Conversation::FFmpegMicrophone.new(
      input_format: "test",
      device: "test"
    )
    spawn = ->(*) { raise "microphone spawned after stop" }

    result = Process.stub(:spawn, spawn) do
      Sync do
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

    assert_nil(result)
  end

  def test_realtime_conversation_rejects_eof_before_the_requested_stop_event
    microphone = RecordingMicrophone.new([])
    playback = OpenAI::Examples::Realtime::Conversation::AudioPlayback.new(
      RecordingSpeaker.new
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Conversation.stream_events(
        RecordingConnection.new,
        microphone: microphone,
        outbound: RecordingOutbound.new,
        playback: playback,
        output: StringIO.new,
        stop_after: "response.done"
      )
    end

    assert_equal("Realtime connection closed before response.done", error.message)
    assert_predicate(microphone, :stopped)
  ensure
    playback&.close
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
        OpenAI::Realtime::ResponseMcpCallArgumentsDone.new(
          arguments: JSON.generate(query: "Realtime WebSocket URL"),
          event_id: "event_1",
          item_id: "mcp_call_1",
          output_index: 0,
          response_id: "response_1"
        ),
        OpenAI::Realtime::ResponseMcpCallCompleted.new(
          event_id: "event_2",
          item_id: "mcp_call_1",
          output_index: 0
        ),
        completed_response_event,
        OpenAI::Realtime::ResponseTextDeltaEvent.new(
          content_index: 0,
          delta: "wss://api.openai.com/v1/realtime",
          event_id: "event_3",
          item_id: "item_2",
          output_index: 0,
          response_id: "response_2"
        ),
        completed_response_event
      ]
    )
    output = StringIO.new

    OpenAI::Examples::Realtime::MCPApproval.run_session(
      connection,
      prompt: "Search the docs",
      output: output
    )

    assert_equal({tool_choice: :none}, connection.response.calls.fetch(0))
    answer_at = output.string.index("wss://api.openai.com/v1/realtime")
    done_at = output.string.rindex("[mcp] response.done status=completed")
    refute_nil(answer_at)
    refute_nil(done_at)
    assert_operator(answer_at, :<, done_at)
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

  def test_websocket_audio_disables_vad_and_waits_for_session_updated
    audio = "assistant pcm".b
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::SessionUpdatedEvent.new(event_id: "event_1", session: {}),
        OpenAI::Realtime::ResponseAudioDeltaEvent.new(
          event_id: "event_2",
          response_id: "response_1",
          item_id: "item_1",
          output_index: 0,
          content_index: 0,
          delta: Base64.strict_encode64(audio)
        ),
        completed_response_event
      ]
    )
    realtime = RecordingRealtime.new(connection)

    Tempfile.create("realtime-input") do |input|
      input.write("input pcm")
      input.flush
      Tempfile.create("realtime-output") do |output|
        _stdout, _stderr = capture_io do
          OpenAI::Examples::Realtime::WebSocketAudio.run(
            client: RecordingClient.new(realtime: realtime),
            model: "gpt-realtime-2.1",
            input_path: input.path,
            output_path: output.path
          )
        end

        assert_equal(audio, File.binread(output.path))
      end
    end

    assert_equal(
      {
        type: :realtime,
        output_modalities: [:audio],
        audio: {input: {turn_detection: nil}}
      },
      connection.session.updates.fetch(0)
    )
    assert_equal(["input pcm"], connection.input_audio_buffer.chunks)
    assert_equal(1, connection.input_audio_buffer.commits)
    assert_equal([{}], connection.response.calls)
    assert_equal([:"session.updated"], connection.received)
  end
end
