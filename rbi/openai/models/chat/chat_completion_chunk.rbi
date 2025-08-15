# typed: strong

module OpenAI
  module Models
    ChatCompletionChunk = Chat::ChatCompletionChunk

    module Chat
      class ChatCompletionChunk < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Chat::ChatCompletionChunk, OpenAI::Internal::AnyHash)
          end

        # A unique identifier for the chat completion. Each chunk has the same ID.
        sig { returns(String) }
        attr_accessor :id

        # A list of chat completion choices. Can contain more than one elements if `n` is
        # greater than 1. Can also be empty for the last chunk if you set
        # `stream_options: {"include_usage": true}`.
        sig { returns(T::Array[OpenAI::Chat::ChatCompletionChunk::Choice]) }
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

        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   '[priority](https://openai.com/api-priority-processing/)', then the request
        #   will be processed with the corresponding service tier.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        sig do
          returns(
            T.nilable(
              OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
            )
          )
        end
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
        sig { returns(T.nilable(OpenAI::CompletionUsage)) }
        attr_reader :usage

        sig { params(usage: T.nilable(OpenAI::CompletionUsage::OrHash)).void }
        attr_writer :usage

        # Represents a streamed chunk of a chat completion response returned by the model,
        # based on the provided input.
        # [Learn more](https://platform.openai.com/docs/guides/streaming-responses).
        sig do
          params(
            id: String,
            choices:
              T::Array[OpenAI::Chat::ChatCompletionChunk::Choice::OrHash],
            created: Integer,
            model: String,
            service_tier:
              T.nilable(
                OpenAI::Chat::ChatCompletionChunk::ServiceTier::OrSymbol
              ),
            system_fingerprint: String,
            usage: T.nilable(OpenAI::CompletionUsage::OrHash),
            object: Symbol
          ).returns(T.attached_class)
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
          # Specifies the processing type used for serving the request.
          #
          # - If set to 'auto', then the request will be processed with the service tier
          #   configured in the Project settings. Unless otherwise configured, the Project
          #   will use 'default'.
          # - If set to 'default', then the request will be processed with the standard
          #   pricing and performance for the selected model.
          # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
          #   '[priority](https://openai.com/api-priority-processing/)', then the request
          #   will be processed with the corresponding service tier.
          # - When not set, the default behavior is 'auto'.
          #
          # When the `service_tier` parameter is set, the response body will include the
          # `service_tier` value based on the processing mode actually used to serve the
          # request. This response value may be different from the value set in the
          # parameter.
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
        )
        end

        sig do
          override.returns(
            {
              id: String,
              choices: T::Array[OpenAI::Chat::ChatCompletionChunk::Choice],
              created: Integer,
              model: String,
              object: Symbol,
              service_tier:
                T.nilable(
                  OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
                ),
              system_fingerprint: String,
              usage: T.nilable(OpenAI::CompletionUsage)
            }
          )
        end
        def to_hash
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionChunk::Choice,
                OpenAI::Internal::AnyHash
              )
            end

          # A chat completion delta generated by streamed model responses.
          sig { returns(OpenAI::Chat::ChatCompletionChunk::Choice::Delta) }
          attr_reader :delta

          sig do
            params(
              delta: OpenAI::Chat::ChatCompletionChunk::Choice::Delta::OrHash
            ).void
          end
          attr_writer :delta

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          sig do
            returns(
              T.nilable(
                OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
              )
            )
          end
          attr_accessor :finish_reason

          # The index of the choice in the list of choices.
          sig { returns(Integer) }
          attr_accessor :index

          # Log probability information for the choice.
          sig do
            returns(
              T.nilable(OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs)
            )
          end
          attr_reader :logprobs

          sig do
            params(
              logprobs:
                T.nilable(
                  OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs::OrHash
                )
            ).void
          end
          attr_writer :logprobs

          sig do
            params(
              delta: OpenAI::Chat::ChatCompletionChunk::Choice::Delta::OrHash,
              finish_reason:
                T.nilable(
                  OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::OrSymbol
                ),
              index: Integer,
              logprobs:
                T.nilable(
                  OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs::OrHash
                )
            ).returns(T.attached_class)
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
          )
          end

          sig do
            override.returns(
              {
                delta: OpenAI::Chat::ChatCompletionChunk::Choice::Delta,
                finish_reason:
                  T.nilable(
                    OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
                  ),
                index: Integer,
                logprobs:
                  T.nilable(OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs)
              }
            )
          end
          def to_hash
          end

          class Delta < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta,
                  OpenAI::Internal::AnyHash
                )
              end

            # The contents of the chunk message.
            sig { returns(T.nilable(String)) }
            attr_accessor :content

            # Deprecated and replaced by `tool_calls`. The name and arguments of a function
            # that should be called, as generated by the model.
            sig do
              returns(
                T.nilable(
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall
                )
              )
            end
            attr_reader :function_call

            sig do
              params(
                function_call:
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall::OrHash
              ).void
            end
            attr_writer :function_call

            # The refusal message generated by the model.
            sig { returns(T.nilable(String)) }
            attr_accessor :refusal

            # The role of the author of this message.
            sig do
              returns(
                T.nilable(
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                )
              )
            end
            attr_reader :role

            sig do
              params(
                role:
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::OrSymbol
              ).void
            end
            attr_writer :role

            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall
                  ]
                )
              )
            end
            attr_reader :tool_calls

            sig do
              params(
                tool_calls:
                  T::Array[
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::OrHash
                  ]
              ).void
            end
            attr_writer :tool_calls

            # A chat completion delta generated by streamed model responses.
            sig do
              params(
                content: T.nilable(String),
                function_call:
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall::OrHash,
                refusal: T.nilable(String),
                role:
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::OrSymbol,
                tool_calls:
                  T::Array[
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::OrHash
                  ]
              ).returns(T.attached_class)
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
            )
            end

            sig do
              override.returns(
                {
                  content: T.nilable(String),
                  function_call:
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall,
                  refusal: T.nilable(String),
                  role:
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol,
                  tool_calls:
                    T::Array[
                      OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall
                    ]
                }
              )
            end
            def to_hash
            end

            class FunctionCall < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall,
                    OpenAI::Internal::AnyHash
                  )
                end

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
              sig do
                params(arguments: String, name: String).returns(
                  T.attached_class
                )
              end
              def self.new(
                # The arguments to call the function with, as generated by the model in JSON
                # format. Note that the model does not always generate valid JSON, and may
                # hallucinate parameters not defined by your function schema. Validate the
                # arguments in your code before calling your function.
                arguments: nil,
                # The name of the function to call.
                name: nil
              )
              end

              sig { override.returns({ arguments: String, name: String }) }
              def to_hash
              end
            end

            # The role of the author of this message.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              DEVELOPER =
                T.let(
                  :developer,
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                )
              SYSTEM =
                T.let(
                  :system,
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                )
              USER =
                T.let(
                  :user,
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                )
              ASSISTANT =
                T.let(
                  :assistant,
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                )
              TOOL =
                T.let(
                  :tool,
                  OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            class ToolCall < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(Integer) }
              attr_accessor :index

              # The ID of the tool call.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              sig do
                returns(
                  T.nilable(
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function
                  )
                )
              end
              attr_reader :function

              sig do
                params(
                  function:
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function::OrHash
                ).void
              end
              attr_writer :function

              # The type of the tool. Currently, only `function` is supported.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol
                  )
                )
              end
              attr_reader :type

              sig do
                params(
                  type:
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::OrSymbol
                ).void
              end
              attr_writer :type

              sig do
                params(
                  index: Integer,
                  id: String,
                  function:
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function::OrHash,
                  type:
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(
                index:,
                # The ID of the tool call.
                id: nil,
                function: nil,
                # The type of the tool. Currently, only `function` is supported.
                type: nil
              )
              end

              sig do
                override.returns(
                  {
                    index: Integer,
                    id: String,
                    function:
                      OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function,
                    type:
                      OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol
                  }
                )
              end
              def to_hash
              end

              class Function < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function,
                      OpenAI::Internal::AnyHash
                    )
                  end

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

                sig do
                  params(arguments: String, name: String).returns(
                    T.attached_class
                  )
                end
                def self.new(
                  # The arguments to call the function with, as generated by the model in JSON
                  # format. Note that the model does not always generate valid JSON, and may
                  # hallucinate parameters not defined by your function schema. Validate the
                  # arguments in your code before calling your function.
                  arguments: nil,
                  # The name of the function to call.
                  name: nil
                )
                end

                sig { override.returns({ arguments: String, name: String }) }
                def to_hash
                end
              end

              # The type of the tool. Currently, only `function` is supported.
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                FUNCTION =
                  T.let(
                    :function,
                    OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
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
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STOP =
              T.let(
                :stop,
                OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
              )
            LENGTH =
              T.let(
                :length,
                OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
              )
            TOOL_CALLS =
              T.let(
                :tool_calls,
                OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
              )
            CONTENT_FILTER =
              T.let(
                :content_filter,
                OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
              )
            FUNCTION_CALL =
              T.let(
                :function_call,
                OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Logprobs < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of message content tokens with log probability information.
            sig do
              returns(
                T.nilable(T::Array[OpenAI::Chat::ChatCompletionTokenLogprob])
              )
            end
            attr_accessor :content

            # A list of message refusal tokens with log probability information.
            sig do
              returns(
                T.nilable(T::Array[OpenAI::Chat::ChatCompletionTokenLogprob])
              )
            end
            attr_accessor :refusal

            # Log probability information for the choice.
            sig do
              params(
                content:
                  T.nilable(
                    T::Array[OpenAI::Chat::ChatCompletionTokenLogprob::OrHash]
                  ),
                refusal:
                  T.nilable(
                    T::Array[OpenAI::Chat::ChatCompletionTokenLogprob::OrHash]
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # A list of message content tokens with log probability information.
              content:,
              # A list of message refusal tokens with log probability information.
              refusal:
            )
            end

            sig do
              override.returns(
                {
                  content:
                    T.nilable(
                      T::Array[OpenAI::Chat::ChatCompletionTokenLogprob]
                    ),
                  refusal:
                    T.nilable(
                      T::Array[OpenAI::Chat::ChatCompletionTokenLogprob]
                    )
                }
              )
            end
            def to_hash
            end
          end
        end

        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   '[priority](https://openai.com/api-priority-processing/)', then the request
        #   will be processed with the corresponding service tier.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::ChatCompletionChunk::ServiceTier)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
            )
          DEFAULT =
            T.let(
              :default,
              OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
            )
          FLEX =
            T.let(
              :flex,
              OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
            )
          SCALE =
            T.let(
              :scale,
              OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
            )
          PRIORITY =
            T.let(
              :priority,
              OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionChunk::ServiceTier::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
