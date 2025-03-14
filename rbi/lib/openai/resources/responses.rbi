# typed: strong

module OpenAI
  module Resources
    class Responses
      sig { returns(OpenAI::Resources::Responses::InputItems) }
      def input_items
      end

      # Creates a model response. Provide
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [image](https://platform.openai.com/docs/guides/images) inputs to generate
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [JSON](https://platform.openai.com/docs/guides/structured-outputs) outputs. Have
      #   the model call your own
      #   [custom code](https://platform.openai.com/docs/guides/function-calling) or use
      #   built-in [tools](https://platform.openai.com/docs/guides/tools) like
      #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      #   [file search](https://platform.openai.com/docs/guides/tools-file-search) to use
      #   your own data as input for the model's response.
      sig do
        params(
          input: T.any(String, OpenAI::Models::Responses::ResponseInput),
          model: T.any(String, Symbol),
          include: T.nilable(T::Array[Symbol]),
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          metadata: T.nilable(OpenAI::Models::Metadata),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          reasoning: T.nilable(OpenAI::Models::Reasoning),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text: OpenAI::Models::Responses::ResponseTextConfig,
          tool_choice: T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction),
          tools: T::Array[
          T.any(
            OpenAI::Models::Responses::FileSearchTool,
            OpenAI::Models::Responses::FunctionTool,
            OpenAI::Models::Responses::ComputerTool,
            OpenAI::Models::Responses::WebSearchTool
          )
          ],
          top_p: T.nilable(Float),
          truncation: T.nilable(Symbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Responses::Response)
      end
      def create(
        input:,
        model:,
        include: nil,
        instructions: nil,
        max_output_tokens: nil,
        metadata: nil,
        parallel_tool_calls: nil,
        previous_response_id: nil,
        reasoning: nil,
        store: nil,
        temperature: nil,
        text: nil,
        tool_choice: nil,
        tools: nil,
        top_p: nil,
        truncation: nil,
        user: nil,
        request_options: {}
      )
      end

      # Creates a model response. Provide
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [image](https://platform.openai.com/docs/guides/images) inputs to generate
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [JSON](https://platform.openai.com/docs/guides/structured-outputs) outputs. Have
      #   the model call your own
      #   [custom code](https://platform.openai.com/docs/guides/function-calling) or use
      #   built-in [tools](https://platform.openai.com/docs/guides/tools) like
      #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      #   [file search](https://platform.openai.com/docs/guides/tools-file-search) to use
      #   your own data as input for the model's response.
      sig do
        params(
          input: T.any(String, OpenAI::Models::Responses::ResponseInput),
          model: T.any(String, Symbol),
          include: T.nilable(T::Array[Symbol]),
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          metadata: T.nilable(OpenAI::Models::Metadata),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          reasoning: T.nilable(OpenAI::Models::Reasoning),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text: OpenAI::Models::Responses::ResponseTextConfig,
          tool_choice: T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction),
          tools: T::Array[
          T.any(
            OpenAI::Models::Responses::FileSearchTool,
            OpenAI::Models::Responses::FunctionTool,
            OpenAI::Models::Responses::ComputerTool,
            OpenAI::Models::Responses::WebSearchTool
          )
          ],
          top_p: T.nilable(Float),
          truncation: T.nilable(Symbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(
            OpenAI::Stream[
            T.any(
              OpenAI::Models::Responses::ResponseAudioDeltaEvent,
              OpenAI::Models::Responses::ResponseAudioDoneEvent,
              OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent,
              OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent,
              OpenAI::Models::Responses::ResponseCompletedEvent,
              OpenAI::Models::Responses::ResponseContentPartAddedEvent,
              OpenAI::Models::Responses::ResponseContentPartDoneEvent,
              OpenAI::Models::Responses::ResponseCreatedEvent,
              OpenAI::Models::Responses::ResponseErrorEvent,
              OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent,
              OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent,
              OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent,
              OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Models::Responses::ResponseInProgressEvent,
              OpenAI::Models::Responses::ResponseFailedEvent,
              OpenAI::Models::Responses::ResponseIncompleteEvent,
              OpenAI::Models::Responses::ResponseOutputItemAddedEvent,
              OpenAI::Models::Responses::ResponseOutputItemDoneEvent,
              OpenAI::Models::Responses::ResponseRefusalDeltaEvent,
              OpenAI::Models::Responses::ResponseRefusalDoneEvent,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent,
              OpenAI::Models::Responses::ResponseTextDeltaEvent,
              OpenAI::Models::Responses::ResponseTextDoneEvent,
              OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent,
              OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent,
              OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent
            )
            ]
          )
      end
      def create_streaming(
        input:,
        model:,
        include: nil,
        instructions: nil,
        max_output_tokens: nil,
        metadata: nil,
        parallel_tool_calls: nil,
        previous_response_id: nil,
        reasoning: nil,
        store: nil,
        temperature: nil,
        text: nil,
        tool_choice: nil,
        tools: nil,
        top_p: nil,
        truncation: nil,
        user: nil,
        request_options: {}
      )
      end

      # Retrieves a model response with the given ID.
      sig do
        params(
          response_id: String,
          include: T::Array[Symbol],
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Responses::Response)
      end
      def retrieve(response_id, include: nil, request_options: {})
      end

      # Deletes a model response with the given ID.
      sig do
        params(
          response_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .void
      end
      def delete(response_id, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
