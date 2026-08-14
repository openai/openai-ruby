# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RealtimeExamplesTestCase < Minitest::Test
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

    def create_function_call_output(**params)
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
    attr_reader :chunks, :commits

    def initialize(writer_fibers = nil)
      @chunks = []
      @commits = 0
      @writer_fibers = writer_fibers
    end

    def append_bytes(bytes)
      @writer_fibers&.push(Fiber.current)
      raise @append_error if @append_error

      @chunks << bytes
    end

    def commit = @commits += 1
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
    attr_reader :conversation, :input_audio_buffer, :received, :response, :session, :writer_fibers

    def initialize(events = [])
      @events = events
      @received = []
      @writer_fibers = []
      @session = RecordingSession.new
      @conversation = RecordingConversation.new(@writer_fibers)
      @input_audio_buffer = RecordingAudioBuffer.new(@writer_fibers)
      @response = RecordingResource.new
    end

    def each
      yield(@events.shift) until @events.empty?
    end

    def receive
      @events.shift.tap { |event| @received << event&.type }
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

    def connect_to_call(call_id:)
      @connections << call_id
      yield(@connection)
    end

    def connect(model:)
      @connections << model
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
