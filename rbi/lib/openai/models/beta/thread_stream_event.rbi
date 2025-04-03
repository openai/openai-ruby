# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::BaseModel
        # Represents a thread that contains
        #   [messages](https://platform.openai.com/docs/api-reference/messages).
        sig { returns(OpenAI::Models::Beta::Thread) }
        attr_reader :data

        sig { params(data: T.any(OpenAI::Models::Beta::Thread, OpenAI::Internal::Util::AnyHash)).void }
        attr_writer :data

        sig { returns(Symbol) }
        attr_accessor :event

        # Whether to enable input audio transcription.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :enabled

        sig { params(enabled: T::Boolean).void }
        attr_writer :enabled

        # Occurs when a new
        #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
        #   created.
        sig do
          params(
            data: T.any(OpenAI::Models::Beta::Thread, OpenAI::Internal::Util::AnyHash),
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
