# typed: strong

module OpenAI
  module Models
    ChatCompletionChunk = T.type_alias { Chat::ChatCompletionChunk }

    module Chat
      class ChatCompletionChunk < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice]) }
        def choices
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice])
        end
        def choices=(_)
        end

        sig { returns(Integer) }
        def created
        end

        sig { params(_: Integer).returns(Integer) }
        def created=(_)
        end

        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def service_tier
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def service_tier=(_)
        end

        sig { returns(T.nilable(String)) }
        def system_fingerprint
        end

        sig { params(_: String).returns(String) }
        def system_fingerprint=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        def usage
        end

        sig { params(_: T.nilable(OpenAI::Models::CompletionUsage)).returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        def usage=(_)
        end

        sig do
          params(
            id: String,
            choices: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice],
            created: Integer,
            model: String,
            service_tier: T.nilable(Symbol),
            system_fingerprint: String,
            usage: T.nilable(OpenAI::Models::CompletionUsage),
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
                service_tier: T.nilable(Symbol),
                system_fingerprint: String,
                usage: T.nilable(OpenAI::Models::CompletionUsage)
              }
            )
        end
        def to_hash
        end

        class Choice < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta) }
          def delta
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta)
              .returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta)
          end
          def delta=(_)
          end

          sig { returns(T.nilable(Symbol)) }
          def finish_reason
          end

          sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
          def finish_reason=(_)
          end

          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs)) }
          def logprobs
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs))
              .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs))
          end
          def logprobs=(_)
          end

          sig do
            params(
              delta: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta,
              finish_reason: T.nilable(Symbol),
              index: Integer,
              logprobs: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs)
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
                  finish_reason: T.nilable(Symbol),
                  index: Integer,
                  logprobs: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs)
                }
              )
          end
          def to_hash
          end

          class Delta < OpenAI::BaseModel
            sig { returns(T.nilable(String)) }
            def content
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def content=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall)) }
            def function_call
            end

            sig do
              params(_: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall)
                .returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall)
            end
            def function_call=(_)
            end

            sig { returns(T.nilable(String)) }
            def refusal
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def refusal=(_)
            end

            sig { returns(T.nilable(Symbol)) }
            def role
            end

            sig { params(_: Symbol).returns(Symbol) }
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

            sig do
              params(
                content: T.nilable(String),
                function_call: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall,
                refusal: T.nilable(String),
                role: Symbol,
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
                    role: Symbol,
                    tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall]
                  }
                )
            end
            def to_hash
            end

            class FunctionCall < OpenAI::BaseModel
              sig { returns(T.nilable(String)) }
              def arguments
              end

              sig { params(_: String).returns(String) }
              def arguments=(_)
              end

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

            class Role < OpenAI::Enum
              abstract!

              DEVELOPER = :developer
              SYSTEM = :system
              USER = :user
              ASSISTANT = :assistant
              TOOL = :tool

              class << self
                sig { override.returns(T::Array[Symbol]) }
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
                params(_: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function)
                  .returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function)
              end
              def function=(_)
              end

              sig { returns(T.nilable(Symbol)) }
              def type
              end

              sig { params(_: Symbol).returns(Symbol) }
              def type=(_)
              end

              sig do
                params(
                  index: Integer,
                  id: String,
                  function: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function,
                  type: Symbol
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
                      type: Symbol
                    }
                  )
              end
              def to_hash
              end

              class Function < OpenAI::BaseModel
                sig { returns(T.nilable(String)) }
                def arguments
                end

                sig { params(_: String).returns(String) }
                def arguments=(_)
                end

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

              class Type < OpenAI::Enum
                abstract!

                FUNCTION = :function

                class << self
                  sig { override.returns(T::Array[Symbol]) }
                  def values
                  end
                end
              end
            end
          end

          class FinishReason < OpenAI::Enum
            abstract!

            STOP = T.let(:stop, T.nilable(Symbol))
            LENGTH = T.let(:length, T.nilable(Symbol))
            TOOL_CALLS = T.let(:tool_calls, T.nilable(Symbol))
            CONTENT_FILTER = T.let(:content_filter, T.nilable(Symbol))
            FUNCTION_CALL = T.let(:function_call, T.nilable(Symbol))

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class Logprobs < OpenAI::BaseModel
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def content
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def content=(_)
            end

            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def refusal
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def refusal=(_)
            end

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

        class ServiceTier < OpenAI::Enum
          abstract!

          SCALE = T.let(:scale, T.nilable(Symbol))
          DEFAULT = T.let(:default, T.nilable(Symbol))

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
