# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Represents a thread that contains
        # [messages](https://platform.openai.com/docs/api-reference/messages).
        sig { returns(OpenAI::Beta::Thread) }
        attr_reader :data

        sig { params(data: OpenAI::Beta::Thread::OrHash).void }
        attr_writer :data

        sig { returns(Symbol) }
        attr_accessor :event

        # Whether to enable input audio transcription.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :enabled

        sig { params(enabled: T::Boolean).void }
        attr_writer :enabled

        # Occurs when a new
        # [thread](https://platform.openai.com/docs/api-reference/threads/object) is
        # created.
        sig do
          params(
            data: OpenAI::Beta::Thread::OrHash,
            enabled: T::Boolean,
            event: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Represents a thread that contains
          # [messages](https://platform.openai.com/docs/api-reference/messages).
          data:,
          # Whether to enable input audio transcription.
          enabled: nil,
          event: :"thread.created"
        )
        end

        sig do
          override.returns(
            { data: OpenAI::Beta::Thread, event: Symbol, enabled: T::Boolean }
          )
        end
        def to_hash
        end
      end
    end
  end
end
