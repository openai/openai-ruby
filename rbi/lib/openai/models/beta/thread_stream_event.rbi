# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::BaseModel
        # Represents a thread that contains
        #   [messages](https://platform.openai.com/docs/api-reference/messages).
        sig { returns(OpenAI::Models::Beta::Thread) }
        def data
        end

        sig do
          params(_: T.any(OpenAI::Models::Beta::Thread, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Beta::Thread, OpenAI::Util::AnyHash))
        end
        def data=(_)
        end

        sig { returns(Symbol) }
        def event
        end

        sig { params(_: Symbol).returns(Symbol) }
        def event=(_)
        end

        # Whether to enable input audio transcription.
        sig { returns(T.nilable(T::Boolean)) }
        def enabled
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def enabled=(_)
        end

        # Occurs when a new
        #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
        #   created.
        sig do
          params(
            data: T.any(OpenAI::Models::Beta::Thread, OpenAI::Util::AnyHash),
            enabled: T::Boolean,
            event: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(data:, enabled: nil, event: :"thread.created")
        end

        sig { override.returns({data: OpenAI::Models::Beta::Thread, event: Symbol, enabled: T::Boolean}) }
        def to_hash
        end
      end
    end
  end
end
