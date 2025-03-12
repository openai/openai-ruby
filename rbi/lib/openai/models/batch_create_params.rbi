# typed: strong

module OpenAI
  module Models
    class BatchCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(Symbol) }
      def completion_window
      end

      sig { params(_: Symbol).returns(Symbol) }
      def completion_window=(_)
      end

      sig { returns(Symbol) }
      def endpoint
      end

      sig { params(_: Symbol).returns(Symbol) }
      def endpoint=(_)
      end

      sig { returns(String) }
      def input_file_id
      end

      sig { params(_: String).returns(String) }
      def input_file_id=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata
      end

      sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata=(_)
      end

      sig do
        params(
          completion_window: Symbol,
          endpoint: Symbol,
          input_file_id: String,
          metadata: T.nilable(OpenAI::Models::Metadata),
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(completion_window:, endpoint:, input_file_id:, metadata: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              completion_window: Symbol,
              endpoint: Symbol,
              input_file_id: String,
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class CompletionWindow < OpenAI::Enum
        abstract!

        NUMBER_24H = :"24h"

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end

      class Endpoint < OpenAI::Enum
        abstract!

        V1_CHAT_COMPLETIONS = :"/v1/chat/completions"
        V1_EMBEDDINGS = :"/v1/embeddings"
        V1_COMPLETIONS = :"/v1/completions"

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
