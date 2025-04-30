# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionChunk < OpenAI::Internal::Type::BaseModel
        # A unique identifier for the chat completion. Each chunk has the same ID.
        sig { returns(String) }
        attr_accessor :id

        # A list of chat completion choices. Can contain more than one elements if `n` is
        # greater than 1. Can also be empty for the last chunk if you set
        # `stream_options: {"include_usage": true}`.
        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice]) }
        attr_accessor :choices

        # The Unix timestamp (in seconds) of when the chat completion was created. Each
        # chunk has the same timestamp.
        sig { returns(Integer) }
        attr_accessor :created

        # The model to generate the completion.
        sig { returns(String) }
        attr_accessor :model

        # The object type, which is always `chat.completion.chunk`.
        sig { returns(Symbol) }
        attr_accessor :object

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)) }
        attr_accessor :service_tier

        # This fingerprint represents the backend configuration that the model runs with.
        # Can be used in conjunction with the `seed` request parameter to understand when
        # backend changes have been made that might impact determinism.
        sig { returns(T.nilable(String)) }
        attr_reader :system_fingerprint

        sig { params(system_fingerprint: String).void }
        attr_writer :system_fingerprint

        # An optional field that will only be present when you set
        # `stream_options: {"include_usage": true}` in your request. When present, it
        # contains a null value **except for the last chunk** which contains the token
        # usage statistics for the entire request.
        #
        # **NOTE:** If the stream is interrupted or cancelled, you may not receive the
        # final usage chunk which contains the total token usage for the request.
        sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        attr_reader :usage

        sig { params(usage: T.nilable(T.any(OpenAI::Models::CompletionUsage, OpenAI::Internal::AnyHash))).void }
        attr_writer :usage

        # Represents a streamed chunk of a chat completion response returned by the model,
        # based on the provided input.
        # [Learn more](https://platform.openai.com/docs/guides/streaming-responses).
        sig do
          params(
            id: String,
            choices: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice, OpenAI::Internal::AnyHash)],
            created: Integer,
            model: String,
            service_tier: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::OrSymbol),
            system_fingerprint: String,
            usage: T.nilable(T.any(OpenAI::Models::CompletionUsage, OpenAI::Internal::AnyHash)),
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          # A unique identifier for the chat completion. Each chunk has the same ID.
          id:,
          # A list of chat completion choices. Can contain more than one elements if `n` is
          # greater than 1. Can also be empty for the last chunk if you set
          # `stream_options: {"include_usage": true}`.
          choices:,
          # The Unix timestamp (in seconds) of when the chat completion was created. Each
          # chunk has the same timestamp.
          created:,
          # The model to generate the completion.
          model:,
          # Specifies the latency tier to use for processing the request. This parameter is
          # relevant for customers subscribed to the scale tier service:
          #
          # - If set to 'auto', and the Project is Scale tier enabled, the system will
          #   utilize scale tier credits until they are exhausted.
          # - If set to 'auto', and the Project is not Scale tier enabled, the request will
          #   be processed using the default service tier with a lower uptime SLA and no
          #   latency guarentee.
          # - If set to 'default', the request will be processed using the default service
          #   tier with a lower uptime SLA and no latency guarentee.
          # - If set to 'flex', the request will be processed with the Flex Processing
          #   service tier.
          #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
          # - When not set, the default behavior is 'auto'.
          #
          # When this parameter is set, the response body will include the `service_tier`
          # utilized.
          service_tier: nil,
          # This fingerprint represents the backend configuration that the model runs with.
          # Can be used in conjunction with the `seed` request parameter to understand when
          # backend changes have been made that might impact determinism.
          system_fingerprint: nil,
          # An optional field that will only be present when you set
          # `stream_options: {"include_usage": true}` in your request. When present, it
          # contains a null value **except for the last chunk** which contains the token
          # usage statistics for the entire request.
          #
          # **NOTE:** If the stream is interrupted or cancelled, you may not receive the
          # final usage chunk which contains the total token usage for the request.
          usage: nil,
          # The object type, which is always `chat.completion.chunk`.
          object: :"chat.completion.chunk"
        ); end
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
        def to_hash; end

        class Choice < OpenAI::Internal::Type::BaseModel
          # A chat completion delta generated by streamed model responses.
          sig { returns(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta) }
          attr_reader :delta

          sig do
            params(delta: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta, OpenAI::Internal::AnyHash))
              .void
          end
          attr_writer :delta

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)) }
          attr_accessor :finish_reason

          # The index of the choice in the list of choices.
          sig { returns(Integer) }
          attr_accessor :index

          # Log probability information for the choice.
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs)) }
          attr_reader :logprobs

          sig do
            params(
              logprobs: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, OpenAI::Internal::AnyHash))
            )
              .void
          end
          attr_writer :logprobs

          sig do
            params(
              delta: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta, OpenAI::Internal::AnyHash),
              finish_reason: T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::OrSymbol),
              index: Integer,
              logprobs: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, OpenAI::Internal::AnyHash))
            )
              .returns(T.attached_class)
          end
          def self.new(
            # A chat completion delta generated by streamed model responses.
            delta:,
            # The reason the model stopped generating tokens. This will be `stop` if the model
            # hit a natural stop point or a provided stop sequence, `length` if the maximum
            # number of tokens specified in the request was reached, `content_filter` if
            # content was omitted due to a flag from our content filters, `tool_calls` if the
            # model called a tool, or `function_call` (deprecated) if the model called a
            # function.
            finish_reason:,
            # The index of the choice in the list of choices.
            index:,
            # Log probability information for the choice.
            logprobs: nil
          ); end
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
          def to_hash; end

          class Delta < OpenAI::Internal::Type::BaseModel
            # The contents of the chunk message.
            sig { returns(T.nilable(String)) }
            attr_accessor :content

            # Deprecated and replaced by `tool_calls`. The name and arguments of a function
            # that should be called, as generated by the model.
            sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall)) }
            attr_reader :function_call

            sig do
              params(
                function_call: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, OpenAI::Internal::AnyHash)
              )
                .void
            end
            attr_writer :function_call

            # The refusal message generated by the model.
            sig { returns(T.nilable(String)) }
            attr_accessor :refusal

            # The role of the author of this message.
            sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)) }
            attr_reader :role

            sig { params(role: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::OrSymbol).void }
            attr_writer :role

            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall])) }
            attr_reader :tool_calls

            sig do
              params(
                tool_calls: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall, OpenAI::Internal::AnyHash)]
              )
                .void
            end
            attr_writer :tool_calls

            # A chat completion delta generated by streamed model responses.
            sig do
              params(
                content: T.nilable(String),
                function_call: T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, OpenAI::Internal::AnyHash),
                refusal: T.nilable(String),
                role: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::OrSymbol,
                tool_calls: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall, OpenAI::Internal::AnyHash)]
              )
                .returns(T.attached_class)
            end
            def self.new(
              # The contents of the chunk message.
              content: nil,
              # Deprecated and replaced by `tool_calls`. The name and arguments of a function
              # that should be called, as generated by the model.
              function_call: nil,
              # The refusal message generated by the model.
              refusal: nil,
              # The role of the author of this message.
              role: nil,
              tool_calls: nil
            ); end
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
            def to_hash; end

            class FunctionCall < OpenAI::Internal::Type::BaseModel
              # The arguments to call the function with, as generated by the model in JSON
              # format. Note that the model does not always generate valid JSON, and may
              # hallucinate parameters not defined by your function schema. Validate the
              # arguments in your code before calling your function.
              sig { returns(T.nilable(String)) }
              attr_reader :arguments

              sig { params(arguments: String).void }
              attr_writer :arguments

              # The name of the function to call.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # Deprecated and replaced by `tool_calls`. The name and arguments of a function
              # that should be called, as generated by the model.
              sig { params(arguments: String, name: String).returns(T.attached_class) }
              def self.new(
                # The arguments to call the function with, as generated by the model in JSON
                # format. Note that the model does not always generate valid JSON, and may
                # hallucinate parameters not defined by your function schema. Validate the
                # arguments in your code before calling your function.
                arguments: nil,
                # The name of the function to call.
                name: nil
              ); end
              sig { override.returns({arguments: String, name: String}) }
              def to_hash; end
            end

            # The role of the author of this message.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              DEVELOPER =
                T.let(:developer, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              SYSTEM = T.let(:system, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              USER = T.let(:user, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              ASSISTANT =
                T.let(:assistant, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)
              TOOL = T.let(:tool, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol]) }
              def self.values; end
            end

            class ToolCall < OpenAI::Internal::Type::BaseModel
              sig { returns(Integer) }
              attr_accessor :index

              # The ID of the tool call.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function)) }
              attr_reader :function

              sig do
                params(
                  function: T.any(
                    OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function,
                    OpenAI::Internal::AnyHash
                  )
                )
                  .void
              end
              attr_writer :function

              # The type of the tool. Currently, only `function` is supported.
              sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol)) }
              attr_reader :type

              sig { params(type: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::OrSymbol).void }
              attr_writer :type

              sig do
                params(
                  index: Integer,
                  id: String,
                  function: T.any(
                    OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function,
                    OpenAI::Internal::AnyHash
                  ),
                  type: OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::OrSymbol
                )
                  .returns(T.attached_class)
              end
              def self.new(
                index:,
                # The ID of the tool call.
                id: nil,
                function: nil,
                # The type of the tool. Currently, only `function` is supported.
                type: nil
              ); end
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
              def to_hash; end

              class Function < OpenAI::Internal::Type::BaseModel
                # The arguments to call the function with, as generated by the model in JSON
                # format. Note that the model does not always generate valid JSON, and may
                # hallucinate parameters not defined by your function schema. Validate the
                # arguments in your code before calling your function.
                sig { returns(T.nilable(String)) }
                attr_reader :arguments

                sig { params(arguments: String).void }
                attr_writer :arguments

                # The name of the function to call.
                sig { returns(T.nilable(String)) }
                attr_reader :name

                sig { params(name: String).void }
                attr_writer :name

                sig { params(arguments: String, name: String).returns(T.attached_class) }
                def self.new(
                  # The arguments to call the function with, as generated by the model in JSON
                  # format. Note that the model does not always generate valid JSON, and may
                  # hallucinate parameters not defined by your function schema. Validate the
                  # arguments in your code before calling your function.
                  arguments: nil,
                  # The name of the function to call.
                  name: nil
                ); end
                sig { override.returns({arguments: String, name: String}) }
                def to_hash; end
              end

              # The type of the tool. Currently, only `function` is supported.
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type) }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                FUNCTION =
                  T.let(:function, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol)

                sig do
                  override
                    .returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol])
                end
                def self.values; end
              end
            end
          end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          module FinishReason
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STOP = T.let(:stop, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            LENGTH = T.let(:length, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            TOOL_CALLS =
              T.let(:tool_calls, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            CONTENT_FILTER =
              T.let(:content_filter, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)
            FUNCTION_CALL =
              T.let(:function_call, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol]) }
            def self.values; end
          end

          class Logprobs < OpenAI::Internal::Type::BaseModel
            # A list of message content tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            attr_accessor :content

            # A list of message refusal tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            attr_accessor :refusal

            # Log probability information for the choice.
            sig do
              params(
                content: T.nilable(T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTokenLogprob, OpenAI::Internal::AnyHash)]),
                refusal: T.nilable(T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTokenLogprob, OpenAI::Internal::AnyHash)])
              )
                .returns(T.attached_class)
            end
            def self.new(
              # A list of message content tokens with log probability information.
              content:,
              # A list of message refusal tokens with log probability information.
              refusal:
            ); end
            sig do
              override
                .returns(
                  {
                    content: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]),
                    refusal: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])
                  }
                )
            end
            def to_hash; end
          end
        end

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO = T.let(:auto, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)
          FLEX = T.let(:flex, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol]) }
          def self.values; end
        end
      end
    end

    ChatCompletionChunk = Chat::ChatCompletionChunk
  end
end
