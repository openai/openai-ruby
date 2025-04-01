# typed: strong

module OpenAI
  module Models
    class VectorStoreCreateParams < OpenAI::BaseModel
      extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      #   strategy. Only applicable if `file_ids` is non-empty.
      sig do
        returns(
          T.nilable(
            T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            )
          )
        )
      end
      attr_reader :chunking_strategy

      sig do
        params(
          chunking_strategy: T.any(
            OpenAI::Models::AutoFileChunkingStrategyParam,
            OpenAI::Util::AnyHash,
            OpenAI::Models::StaticFileChunkingStrategyObjectParam
          )
        )
          .void
      end
      attr_writer :chunking_strategy

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(expires_after: T.any(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter, OpenAI::Util::AnyHash))
          .void
      end
      attr_writer :expires_after

      # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      #   the vector store should use. Useful for tools like `file_search` that can access
      #   files.
      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :file_ids

      sig { params(file_ids: T::Array[String]).void }
      attr_writer :file_ids

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the vector store.
      sig { returns(T.nilable(String)) }
      attr_reader :name

      sig { params(name: String).void }
      attr_writer :name

      sig do
        params(
          chunking_strategy: T.any(
            OpenAI::Models::AutoFileChunkingStrategyParam,
            OpenAI::Util::AnyHash,
            OpenAI::Models::StaticFileChunkingStrategyObjectParam
          ),
          expires_after: T.any(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter, OpenAI::Util::AnyHash),
          file_ids: T::Array[String],
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        chunking_strategy: nil,
        expires_after: nil,
        file_ids: nil,
        metadata: nil,
        name: nil,
        request_options: {}
      )
      end

      sig do
        override
          .returns(
            {
              chunking_strategy: T.any(
                OpenAI::Models::AutoFileChunkingStrategyParam,
                OpenAI::Models::StaticFileChunkingStrategyObjectParam
              ),
              expires_after: OpenAI::Models::VectorStoreCreateParams::ExpiresAfter,
              file_ids: T::Array[String],
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::BaseModel
        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `last_active_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        attr_accessor :days

        # The expiration policy for a vector store.
        sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
        def self.new(days:, anchor: :last_active_at)
        end

        sig { override.returns({anchor: Symbol, days: Integer}) }
        def to_hash
        end
      end
    end
  end
end
