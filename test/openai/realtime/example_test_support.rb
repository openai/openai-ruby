# frozen_string_literal: true

module OpenAI::Test::RealtimeExampleTestSupport
  class RecordingResource
    attr_reader :calls

    def initialize = @calls = []
    def create(**params) = @calls << params
    def update(**params) = @calls << params
  end

  class RecordingConversation
    attr_reader :items

    def initialize = @items = RecordingResource.new
  end

  class RecordingConnection
    attr_reader :conversation, :response, :session

    def initialize(events)
      @events = events.dup
      @conversation = RecordingConversation.new
      @response = RecordingResource.new
      @session = RecordingResource.new
    end

    def each
      yield(@events.shift) until @events.empty?
      self
    end
  end

  class RecordingRealtime
    attr_reader :models

    def initialize(connection)
      @connection = connection
      @models = []
    end

    def connect(model:)
      @models << model
      yield(@connection)
    end
  end

  RecordingClient = Data.define(:realtime)

  private def recording_client(events)
    connection = RecordingConnection.new(events)
    realtime = RecordingRealtime.new(connection)
    [RecordingClient.new(realtime: realtime), connection, realtime]
  end

  private def response_done(id: "response_1", status: :completed, text: nil)
    output = text.nil? ? [] : [assistant_message(text)]
    OpenAI::Realtime::ResponseDoneEvent.new(
      event_id: "event_#{id}",
      response: OpenAI::Realtime::RealtimeResponse.new(id: id, status: status, output: output)
    )
  end

  private def assistant_message(text)
    OpenAI::Realtime::RealtimeConversationItemAssistantMessage.new(
      id: "message_1",
      status: :completed,
      content: [
        OpenAI::Realtime::RealtimeConversationItemAssistantMessage::Content.new(
          type: :output_text,
          text: text
        )
      ]
    )
  end

  private def api_error(message = "private service error")
    OpenAI::Realtime::RealtimeErrorEvent.new(
      event_id: "event_error",
      error: OpenAI::Realtime::RealtimeError.new(
        message: message,
        type: "invalid_request_error"
      )
    )
  end
end
