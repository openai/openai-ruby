# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionChunk < OpenAI::BaseModel
        # A unique identifier for the chat completion. Each chunk has the same ID.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # A list of chat completion choices. Can contain more than one elements if `n` is
        #   greater than 1. Can also be empty for the last chunk if you set
        #   `stream_options: {"include_usage": true}`.
        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice]) }
        def choices
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice])
        end
        def choices=(_)
        end

        # The Unix timestamp (in seconds) of when the chat completion was created. Each
        #   chunk has the same timestamp.
        sig { returns(Integer) }
        def created
        end

        sig { params(_: Integer).returns(Integer) }
        def created=(_)
        end

        # The model to generate the completion.
        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        # The object type, which is always `chat.completion.chunk`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The service tier used for processing the request.
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)) }
        def service_tier
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol))
        end
        def service_tier=(_)
        end

        # This fingerprint represents the backend configuration that the model runs with.
        #   Can be used in conjunction with the `seed` request parameter to understand when
        #   backend changes have been made that might impact determinism.
        sig { returns(T.nilable(String)) }
        def system_fingerprint
        end

        sig { params(_: String).returns(String) }
        def system_fingerprint=(_)
        end

        # An optional field that will only be present when you set
        #   `stream_options: {"include_usage": true}` in your request. When present, it
        #   contains a null value **except for the last chunk** which contains the token
        #   usage statistics for the entire request.
        #
        #   **NOTE:** If the stream is interrupted or cancelled, you may not receive the
        #   final usage chunk which contains the total token usage for the request.
        sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        def usage
        end

        sig do
          params(_: T.nilable(T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash)))
            .returns(T.nilable(T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash)))
        end
        def usage=(_)
        end

        # Represents a streamed chunk of a chat completion response returned by the model,
        #   based on the provided input.
        #   [Learn more](https://platform.openai.com/docs/guides/streaming-responses).
        sig do
          params(
            id: String,
            choices: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice],
            created: Integer,
            model: String,
            service_tier: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol),
            system_fingerprint: String,
            usage: T.nilable(T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash)),
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          choices:,
          created:,
          model:,
          service_tier: nil,
          system_fingerprint: nil,
          usage: nil,
          object: :"chat.completion.chunk"
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                choices: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice],
                created: Integer,
                model: String,
                object: Symbol,
                service_tier: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol),
                system_fingerprint: String,
                usage: T.nilable(OpenAI::Models::CompletionUsage)
              }
            )
        end
        def to_hash
        end

        class Choice < OpenAI::BaseModel
          # A chat completion delta generated by streamed model responses.
          sig { returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta) }
          def delta
          end

          sig do
            params(_: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta, OpenAI::Util::AnyHash))
          end
          def delta=(_)
          end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function.
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)) }
          def finish_reason
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol))
              .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol))
          end
          def finish_reason=(_)
          end

          # The index of the choice in the list of choices.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Log probability information for the choice.
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs)) }
          def logprobs
          end

          sig do
            params(
              _: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, OpenAI::Util::AnyHash))
            )
              .returns(
                T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, OpenAI::Util::AnyHash))
              )
          end
          def logprobs=(_)
          end

          sig do
            params(
              delta: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta, OpenAI::Util::AnyHash),
              finish_reason: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol),
              index: Integer,
              logprobs: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, OpenAI::Util::AnyHash))
            )
              .returns(T.attached_class)
          end
          def self.new(delta:, finish_reason:, index:, logprobs: nil)
          end

          sig do
            override
              .returns(
                {
                  delta: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta,
                  finish_reason: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol),
                  index: Integer,
                  logprobs: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs)
                }
              )
          end
          def to_hash
          end

          class Delta < OpenAI::BaseModel
            # The contents of the chunk message.
            sig { returns(T.nilable(String)) }
            def content
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def content=(_)
            end

            # Deprecated and replaced by `tool_calls`. The name and arguments of a function
            #   that should be called, as generated by the model.
            sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall)) }
            def function_call
            end

            sig do
              params(
                _: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, OpenAI::Util::AnyHash)
              )
                .returns(
                  T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, OpenAI::Util::AnyHash)
                )
            end
            def function_call=(_)
            end

            # The refusal message generated by the model.
            sig { returns(T.nilable(String)) }
            def refusal
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def refusal=(_)
            end

            # The role of the author of this message.
            sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)) }
            def role
            end

            sig do
              params(_: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
                .returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
            end
            def role=(_)
            end

            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall])) }
            def tool_calls
            end

            sig do
              params(_: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall])
                .returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall])
            end
            def tool_calls=(_)
            end

            # A chat completion delta generated by streamed model responses.
            sig do
              params(
                content: T.nilable(String),
                function_call: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, OpenAI::Util::AnyHash),
                refusal: T.nilable(String),
                role: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol,
                tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall]
              )
                .returns(T.attached_class)
            end
            def self.new(content: nil, function_call: nil, refusal: nil, role: nil, tool_calls: nil)
            end

            sig do
              override
                .returns(
                  {
                    content: T.nilable(String),
                    function_call: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall,
                    refusal: T.nilable(String),
                    role: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol,
                    tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall]
                  }
                )
            end
            def to_hash
            end

            class FunctionCall < OpenAI::BaseModel
              # The arguments to call the function with, as generated by the model in JSON
              #   format. Note that the model does not always generate valid JSON, and may
              #   hallucinate parameters not defined by your function schema. Validate the
              #   arguments in your code before calling your function.
              sig { returns(T.nilable(String)) }
              def arguments
              end

              sig { params(_: String).returns(String) }
              def arguments=(_)
              end

              # The name of the function to call.
              sig { returns(T.nilable(String)) }
              def name
              end

              sig { params(_: String).returns(String) }
              def name=(_)
              end

              # Deprecated and replaced by `tool_calls`. The name and arguments of a function
              #   that should be called, as generated by the model.
              sig { params(arguments: String, name: String).returns(T.attached_class) }
              def self.new(arguments: nil, name: nil)
              end

              sig { override.returns({arguments: String, name: String}) }
              def to_hash
              end
            end

            # The role of the author of this message.
            module Role
              extend OpenAI::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol) }

              DEVELOPER =
                T.let(:developer, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              SYSTEM = T.let(:system, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              USER = T.let(:user, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              ASSISTANT =
                T.let(:assistant, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              TOOL = T.let(:tool, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)

              class << self
                sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol]) }
                def values
                end
              end
            end

            class ToolCall < OpenAI::BaseModel
              sig { returns(Integer) }
              def index
              end

              sig { params(_: Integer).returns(Integer) }
              def index=(_)
              end

              # The ID of the tool call.
              sig { returns(T.nilable(String)) }
              def id
              end

              sig { params(_: String).returns(String) }
              def id=(_)
              end

              sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function)) }
              def function
              end

              sig do
                params(
                  _: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function, OpenAI::Util::AnyHash)
                )
                  .returns(
                    T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function, OpenAI::Util::AnyHash)
                  )
              end
              def function=(_)
              end

              # The type of the tool. Currently, only `function` is supported.
              sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol)) }
              def type
              end

              sig do
                params(_: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol)
                  .returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol)
              end
              def type=(_)
              end

              sig do
                params(
                  index: Integer,
                  id: String,
                  function: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function, OpenAI::Util::AnyHash),
                  type: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol
                )
                  .returns(T.attached_class)
              end
              def self.new(index:, id: nil, function: nil, type: nil)
              end

              sig do
                override
                  .returns(
                    {
                      index: Integer,
                      id: String,
                      function: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function,
                      type: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol
                    }
                  )
              end
              def to_hash
              end

              class Function < OpenAI::BaseModel
                # The arguments to call the function with, as generated by the model in JSON
                #   format. Note that the model does not always generate valid JSON, and may
                #   hallucinate parameters not defined by your function schema. Validate the
                #   arguments in your code before calling your function.
                sig { returns(T.nilable(String)) }
                def arguments
                end

                sig { params(_: String).returns(String) }
                def arguments=(_)
                end

                # The name of the function to call.
                sig { returns(T.nilable(String)) }
                def name
                end

                sig { params(_: String).returns(String) }
                def name=(_)
                end

                sig { params(arguments: String, name: String).returns(T.attached_class) }
                def self.new(arguments: nil, name: nil)
                end

                sig { override.returns({arguments: String, name: String}) }
                def to_hash
                end
              end

              # The type of the tool. Currently, only `function` is supported.
              module Type
                extend OpenAI::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type) }
                OrSymbol =
                  T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol) }

                FUNCTION =
                  T.let(:function, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol)

                class << self
                  sig do
                    override
                      .returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol])
                  end
                  def values
                  end
                end
              end
            end
          end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function.
          module FinishReason
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol) }

            STOP = T.let(:stop, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            LENGTH = T.let(:length, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            TOOL_CALLS =
              T.let(:tool_calls, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            CONTENT_FILTER =
              T.let(:content_filter, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            FUNCTION_CALL =
              T.let(:function_call, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)

            class << self
              sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol]) }
              def values
              end
            end
          end

          class Logprobs < OpenAI::BaseModel
            # A list of message content tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def content
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def content=(_)
            end

            # A list of message refusal tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def refusal
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def refusal=(_)
            end

            # Log probability information for the choice.
            sig do
              params(
                content: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]),
                refusal: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])
              )
                .returns(T.attached_class)
            end
            def self.new(content:, refusal:)
            end

            sig do
              override
                .returns(
                  {
                    content: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]),
                    refusal: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])
                  }
                )
            end
            def to_hash
            end
          end
        end

        # The service tier used for processing the request.
        module ServiceTier
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol) }

          SCALE = T.let(:scale, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end

    ChatCompletionChunk = Chat::ChatCompletionChunk
  end
end
