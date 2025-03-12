# typed: strong

module OpenAI
  module Resources
    class Beta
      class Assistants
        sig do
          params(
            model: T.any(String, Symbol),
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(OpenAI::Models::Metadata),
            name: T.nilable(String),
            reasoning_effort: T.nilable(Symbol),
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Assistant)
        end
        def create(
          model:,
          description: nil,
          instructions: nil,
          metadata: nil,
          name: nil,
          reasoning_effort: nil,
          response_format: nil,
          temperature: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          request_options: {}
        )
        end

        sig do
          params(
            assistant_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Assistant)
        end
        def retrieve(assistant_id, request_options: {})
        end

        sig do
          params(
            assistant_id: String,
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: T.any(String, Symbol),
            name: T.nilable(String),
            reasoning_effort: T.nilable(Symbol),
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Assistant)
        end
        def update(
          assistant_id,
          description: nil,
          instructions: nil,
          metadata: nil,
          model: nil,
          name: nil,
          reasoning_effort: nil,
          response_format: nil,
          temperature: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          request_options: {}
        )
        end

        sig do
          params(
            after: String,
            before: String,
            limit: Integer,
            order: Symbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::Beta::Assistant])
        end
        def list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
        end

        sig do
          params(
            assistant_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::AssistantDeleted)
        end
        def delete(assistant_id, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
