# typed: strong

module OpenAI
  module Models
    ChatCompletionMessage = T.type_alias { Chat::ChatCompletionMessage }

    module Chat
      class ChatCompletionMessage < OpenAI::BaseModel
        sig { returns(T.nilable(String)) }
        def content
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def content=(_)
        end

        sig { returns(T.nilable(String)) }
        def refusal
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def refusal=(_)
        end

        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionMessage::Annotation])) }
        def annotations
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionMessage::Annotation])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionMessage::Annotation])
        end
        def annotations=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAudio)) }
        def audio
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionAudio))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAudio))
        end
        def audio=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall)) }
        def function_call
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall)
            .returns(OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall)
        end
        def function_call=(_)
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
            content: T.nilable(String),
            refusal: T.nilable(String),
            annotations: T::Array[OpenAI::Models::Chat::ChatCompletionMessage::Annotation],
            audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudio),
            function_call: OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall,
            tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall],
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, refusal:, annotations: nil, audio: nil, function_call: nil, tool_calls: nil, role: :assistant)
        end

        sig do
          override
            .returns(
              {
                content: T.nilable(String),
                refusal: T.nilable(String),
                role: Symbol,
                annotations: T::Array[OpenAI::Models::Chat::ChatCompletionMessage::Annotation],
                audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudio),
                function_call: OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall,
                tool_calls: T::Array[OpenAI::Models::Chat::ChatCompletionMessageToolCall]
              }
            )
        end
        def to_hash
        end

        class Annotation < OpenAI::BaseModel
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(OpenAI::Models::Chat::ChatCompletionMessage::Annotation::URLCitation) }
          def url_citation
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletionMessage::Annotation::URLCitation)
              .returns(OpenAI::Models::Chat::ChatCompletionMessage::Annotation::URLCitation)
          end
          def url_citation=(_)
          end

          sig do
            params(url_citation: OpenAI::Models::Chat::ChatCompletionMessage::Annotation::URLCitation, type: Symbol)
              .returns(T.attached_class)
          end
          def self.new(url_citation:, type: :url_citation)
          end

          sig do
            override
              .returns(
                {type: Symbol, url_citation: OpenAI::Models::Chat::ChatCompletionMessage::Annotation::URLCitation}
              )
          end
          def to_hash
          end

          class URLCitation < OpenAI::BaseModel
            sig { returns(Integer) }
            def end_index
            end

            sig { params(_: Integer).returns(Integer) }
            def end_index=(_)
            end

            sig { returns(Integer) }
            def start_index
            end

            sig { params(_: Integer).returns(Integer) }
            def start_index=(_)
            end

            sig { returns(String) }
            def title
            end

            sig { params(_: String).returns(String) }
            def title=(_)
            end

            sig { returns(String) }
            def url
            end

            sig { params(_: String).returns(String) }
            def url=(_)
            end

            sig do
              params(
                end_index: Integer,
                start_index: Integer,
                title: String,
                url: String
              ).returns(T.attached_class)
            end
            def self.new(end_index:, start_index:, title:, url:)
            end

            sig { override.returns({end_index: Integer, start_index: Integer, title: String, url: String}) }
            def to_hash
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
