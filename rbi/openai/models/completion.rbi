# typed: strong

module OpenAI
  module Models
    class Completion < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # A unique identifier for the completion.
      sig { returns(String) }
      attr_accessor :id

      # The list of completion choices the model generated for the input prompt.
      sig { returns(T::Array[OpenAI::CompletionChoice]) }
      attr_accessor :choices

      # The Unix timestamp (in seconds) of when the completion was created.
      sig { returns(Integer) }
      attr_accessor :created

      # The model used for completion.
      sig { returns(String) }
      attr_accessor :model

      # The object type, which is always "text_completion"
      sig { returns(Symbol) }
      attr_accessor :object

      # This fingerprint represents the backend configuration that the model runs with.
      #
      # Can be used in conjunction with the `seed` request parameter to understand when
      # backend changes have been made that might impact determinism.
      sig { returns(T.nilable(String)) }
      attr_reader :system_fingerprint

      sig { params(system_fingerprint: String).void }
      attr_writer :system_fingerprint

      # Usage statistics for the completion request.
      sig { returns(T.nilable(OpenAI::CompletionUsage)) }
      attr_reader :usage

      sig { params(usage: OpenAI::CompletionUsage::OrHash).void }
      attr_writer :usage

      # Represents a completion response from the API. Note: both the streamed and
      # non-streamed response objects share the same shape (unlike the chat endpoint).
      sig do
        params(
          id: String,
          choices: T::Array[OpenAI::CompletionChoice::OrHash],
          created: Integer,
          model: String,
          system_fingerprint: String,
          usage: OpenAI::CompletionUsage::OrHash,
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # A unique identifier for the completion.
        id:,
        # The list of completion choices the model generated for the input prompt.
        choices:,
        # The Unix timestamp (in seconds) of when the completion was created.
        created:,
        # The model used for completion.
        model:,
        # This fingerprint represents the backend configuration that the model runs with.
        #
        # Can be used in conjunction with the `seed` request parameter to understand when
        # backend changes have been made that might impact determinism.
        system_fingerprint: nil,
        # Usage statistics for the completion request.
        usage: nil,
        # The object type, which is always "text_completion"
        object: :text_completion
      )
      end

      sig do
        override.returns(
          {
            id: String,
            choices: T::Array[OpenAI::CompletionChoice],
            created: Integer,
            model: String,
            object: Symbol,
            system_fingerprint: String,
            usage: OpenAI::CompletionUsage
          }
        )
      end
      def to_hash
      end
    end
  end
end
