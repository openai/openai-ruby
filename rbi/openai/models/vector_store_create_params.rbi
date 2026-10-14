# typed: strong

module OpenAI
  module Models
    class VectorStoreCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VectorStoreCreateParams, OpenAI::Internal::AnyHash)
        end

      # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
      # strategy. Only applicable if `file_ids` is non-empty.
      sig do
        returns(
          T.nilable(
            T.any(
              OpenAI::AutoFileChunkingStrategyParam,
              OpenAI::StaticFileChunkingStrategyObjectParam
            )
          )
        )
      end
      attr_reader :chunking_strategy

      sig do
        params(
          chunking_strategy:
            T.any(
              OpenAI::AutoFileChunkingStrategyParam::OrHash,
              OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
            )
        ).void
      end
      attr_writer :chunking_strategy

      # A description for the vector store. Can be used to describe the vector store's
      # purpose.
      sig { returns(T.nilable(String)) }
      attr_reader :description

      sig { params(description: String).void }
      attr_writer :description

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::VectorStoreCreateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(
          expires_after: OpenAI::VectorStoreCreateParams::ExpiresAfter::OrHash
        ).void
      end
      attr_writer :expires_after

      # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      # the vector store should use. Useful for tools like `file_search` that can access
      # files.
      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :file_ids

      sig { params(file_ids: T::Array[String]).void }
      attr_writer :file_ids

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the vector store.
      sig { returns(T.nilable(String)) }
      attr_reader :name

      sig { params(name: String).void }
      attr_writer :name

      sig do
        params(
          chunking_strategy:
            T.any(
              OpenAI::AutoFileChunkingStrategyParam::OrHash,
              OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
            ),
          description: String,
          expires_after: OpenAI::VectorStoreCreateParams::ExpiresAfter::OrHash,
          file_ids: T::Array[String],
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
        # strategy. Only applicable if `file_ids` is non-empty.
        chunking_strategy: nil,
        # A description for the vector store. Can be used to describe the vector store's
        # purpose.
        description: nil,
        # The expiration policy for a vector store.
        expires_after: nil,
        # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        # the vector store should use. Useful for tools like `file_search` that can access
        # files.
        file_ids: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # The name of the vector store.
        name: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            chunking_strategy:
              T.any(
                OpenAI::AutoFileChunkingStrategyParam,
                OpenAI::StaticFileChunkingStrategyObjectParam
              ),
            description: String,
            expires_after: OpenAI::VectorStoreCreateParams::ExpiresAfter,
            file_ids: T::Array[String],
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::VectorStoreCreateParams::ExpiresAfter,
              OpenAI::Internal::AnyHash
            )
          end

        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        # `last_active_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        attr_accessor :days

        # The expiration policy for a vector store.
        sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
        def self.new(
          # The number of days after the anchor time that the vector store will expire.
          days:,
          # Anchor timestamp after which the expiration policy applies. Supported anchors:
          # `last_active_at`.
          anchor: :last_active_at
        )
        end

        sig { override.returns({ anchor: Symbol, days: Integer }) }
        def to_hash
        end
      end
    end
  end
end
