# typed: strong

module OpenAI
  module Models
    class VectorStoreCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
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
      def chunking_strategy
      end

      sig do
        params(
          _: T.any(
            OpenAI::Models::AutoFileChunkingStrategyParam,
            OpenAI::Models::StaticFileChunkingStrategyObjectParam
          )
        )
          .returns(
            T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            )
          )
      end
      def chunking_strategy=(_)
      end

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)) }
      def expires_after
      end

      sig do
        params(_: OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)
          .returns(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)
      end
      def expires_after=(_)
      end

      # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
      #   the vector store should use. Useful for tools like `file_search` that can access
      #   files.
      sig { returns(T.nilable(T::Array[String])) }
      def file_ids
      end

      sig { params(_: T::Array[String]).returns(T::Array[String]) }
      def file_ids=(_)
      end

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      def metadata
      end

      sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
      def metadata=(_)
      end

      # The name of the vector store.
      sig { returns(T.nilable(String)) }
      def name
      end

      sig { params(_: String).returns(String) }
      def name=(_)
      end

      sig do
        params(
          chunking_strategy: T.any(
            OpenAI::Models::AutoFileChunkingStrategyParam,
            OpenAI::Models::StaticFileChunkingStrategyObjectParam
          ),
          expires_after: OpenAI::Models::VectorStoreCreateParams::ExpiresAfter,
          file_ids: T::Array[String],
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(chunking_strategy: nil, expires_after: nil, file_ids: nil, metadata: nil, name: nil, request_options: {})
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
        def anchor
        end

        sig { params(_: Symbol).returns(Symbol) }
        def anchor=(_)
        end

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        def days
        end

        sig { params(_: Integer).returns(Integer) }
        def days=(_)
        end

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
