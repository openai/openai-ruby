# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionAssistantMessageParam < OpenAI::BaseModel
        # The role of the messages author, in this case `assistant`.
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        # Data about a previous audio response from the model.
        #   [Learn more](https://platform.openai.com/docs/guides/audio).
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio)) }
        def audio
        end

        sig do
          params(
            _: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio, OpenAI::Util::AnyHash))
          )
            .returns(
              T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio, OpenAI::Util::AnyHash))
            )
        end
        def audio=(_)
        end

        # The contents of the assistant message. Required unless `tool_calls` or
        #   `function_call` is specified.
        sig do
          returns(
            T.nilable(
              T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Chat::ChatCompletionContentPartText,
                  OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                )
                ]
              )
            )
          )
        end
        def content
        end

        sig do
          params(
            _: T.nilable(
              T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Chat::ChatCompletionContentPartText,
                  OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                )
                ]
              )
            )
          )
            .returns(
              T.nilable(
                T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Chat::ChatCompletionContentPartText,
                    OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                  )
                  ]
                )
              )
            )
        end
        def content=(_)
        end

        # Deprecated and replaced by `tool_calls`. The name and arguments of a function
        #   that should be called, as generated by the model.
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall)) }
        def function_call
        end

        sig do
          params(
            _: T.nilable(
              T.any(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall, OpenAI::Util::AnyHash)
            )
          )
            .returns(
              T.nilable(
                T.any(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall, OpenAI::Util::AnyHash)
              )
            )
        end
        def function_call=(_)
        end

        # An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # The refusal message by the assistant.
        sig { returns(T.nilable(String)) }
        def refusal
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def refusal=(_)
        end

        # The tool calls generated by the model, such as function calls.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall])) }
        def tool_calls
        end

        sig do
          params(_: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionMessageToolCall, OpenAI::Util::AnyHash)])
            .returns(T::Array[T.any(OpenAI::Models::Chat::ChatCompletionMessageToolCall, OpenAI::Util::AnyHash)])
        end
        def tool_calls=(_)
        end

        # Messages sent by the model in response to user messages.
        sig do
          params(
            audio: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio, OpenAI::Util::AnyHash)),
            content: T.nilable(
              T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Chat::ChatCompletionContentPartText,
                  OpenAI::Util::AnyHash,
                  OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                )
                ]
              )
            ),
            function_call: T.nilable(
              T.any(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall, OpenAI::Util::AnyHash)
            ),
            name: String,
            refusal: T.nilable(String),
            tool_calls: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionMessageToolCall, OpenAI::Util::AnyHash)],
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(audio: nil, content: nil, function_call: nil, name: nil, refusal: nil, tool_calls: nil, role: :assistant)
        end

        sig do
          override
            .returns(
              {
                role: Symbol,
                audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio),
                content: T.nilable(
                  T.any(
                    String,
                    T::Array[
                    T.any(
                      OpenAI::Models::Chat::ChatCompletionContentPartText,
                      OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                    )
                    ]
                  )
                ),
                function_call: T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall),
                name: String,
                refusal: T.nilable(String),
                tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall]
              }
            )
        end
        def to_hash
        end

        class Audio < OpenAI::BaseModel
          # Unique identifier for a previous audio response from the model.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # Data about a previous audio response from the model.
          #   [Learn more](https://platform.openai.com/docs/guides/audio).
          sig { params(id: String).returns(T.attached_class) }
          def self.new(id:)
          end

          sig { override.returns({id: String}) }
          def to_hash
          end
        end

        # The contents of the assistant message. Required unless `tool_calls` or
        #   `function_call` is specified.
        module Content
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Chat::ChatCompletionContentPartText,
                    OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                  )
                  ]
                )
              }
            end

          ArrayOfContentPartArray =
            T.let(
              OpenAI::ArrayOf[union: OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Content::ArrayOfContentPart],
              OpenAI::Converter
            )

          # Learn about
          #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
          module ArrayOfContentPart
            extend OpenAI::Union

            Variants =
              type_template(:out) do
                {
                  fixed: T.any(
                    OpenAI::Models::Chat::ChatCompletionContentPartText,
                    OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                  )
                }
              end

            class << self
              sig do
                override
                  .returns(
                    [OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartRefusal]
                  )
              end
              def variants
              end
            end
          end

          class << self
            sig do
              override
                .returns(
                  [
                    String,
                    T::Array[
                                      T.any(
                                        OpenAI::Models::Chat::ChatCompletionContentPartText,
                                        OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                                      )
                                      ]
                  ]
                )
            end
            def variants
            end
          end
        end

        class FunctionCall < OpenAI::BaseModel
          # The arguments to call the function with, as generated by the model in JSON
          #   format. Note that the model does not always generate valid JSON, and may
          #   hallucinate parameters not defined by your function schema. Validate the
          #   arguments in your code before calling your function.
          sig { returns(String) }
          def arguments
          end

          sig { params(_: String).returns(String) }
          def arguments=(_)
          end

          # The name of the function to call.
          sig { returns(String) }
          def name
          end

          sig { params(_: String).returns(String) }
          def name=(_)
          end

          # Deprecated and replaced by `tool_calls`. The name and arguments of a function
          #   that should be called, as generated by the model.
          sig { params(arguments: String, name: String).returns(T.attached_class) }
          def self.new(arguments:, name:)
          end

          sig { override.returns({arguments: String, name: String}) }
          def to_hash
          end
        end
      end
    end

    ChatCompletionAssistantMessageParam = Chat::ChatCompletionAssistantMessageParam
  end
end
