# typed: strong

module OpenAI
  module Models
    ChatCompletionAssistantMessageParam = T.type_alias { Chat::ChatCompletionAssistantMessageParam }

    module Chat
      class ChatCompletionAssistantMessageParam < OpenAI::BaseModel
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio)) }
        def audio
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::Audio))
        end
        def audio=(_)
        end

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

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall)) }
        def function_call
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAssistantMessageParam::FunctionCall))
        end
        def function_call=(_)
        end

        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig { returns(T.nilable(String)) }
        def refusal
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def refusal=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall])) }
        def tool_calls
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall])
        end
        def tool_calls=(_)
        end

        sig do
          params(
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
            tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall],
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
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          sig { params(id: String).returns(T.attached_class) }
          def self.new(id:)
          end

          sig { override.returns({id: String}) }
          def to_hash
          end
        end

        class Content < OpenAI::Union
          abstract!

          ArrayOfContentPartArray = T.type_alias do
            T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionContentPartText,
              OpenAI::Models::Chat::ChatCompletionContentPartRefusal
            )
            ]
          end

          class ArrayOfContentPart < OpenAI::Union
            abstract!

            class << self
              sig do
                override
                  .returns(
                    [[Symbol, OpenAI::Models::Chat::ChatCompletionContentPartText], [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartRefusal]]
                  )
              end
              private def variants
              end
            end
          end

          class << self
            sig do
              override
                .returns(
                  [
                    [NilClass, String],
                    [
                      NilClass,
                      T::Array[
                                        T.any(
                                          OpenAI::Models::Chat::ChatCompletionContentPartText,
                                          OpenAI::Models::Chat::ChatCompletionContentPartRefusal
                                        )
                                        ]
                    ]
                  ]
                )
            end
            private def variants
            end
          end
        end

        class FunctionCall < OpenAI::BaseModel
          sig { returns(String) }
          def arguments
          end

          sig { params(_: String).returns(String) }
          def arguments=(_)
          end

          sig { returns(String) }
          def name
          end

          sig { params(_: String).returns(String) }
          def name=(_)
          end

          sig { params(arguments: String, name: String).returns(T.attached_class) }
          def self.new(arguments:, name:)
          end

          sig { override.returns({arguments: String, name: String}) }
          def to_hash
          end
        end
      end
    end
  end
end
