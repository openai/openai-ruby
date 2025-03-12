# typed: strong

module OpenAI
  module Models
    class VectorStoreCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

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

      sig { returns(T.nilable(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)) }
      def expires_after
      end

      sig do
        params(_: OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)
          .returns(OpenAI::Models::VectorStoreCreateParams::ExpiresAfter)
      end
      def expires_after=(_)
      end

      sig { returns(T.nilable(T::Array[String])) }
      def file_ids
      end

      sig { params(_: T::Array[String]).returns(T::Array[String]) }
      def file_ids=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata
      end

      sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata=(_)
      end

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
          metadata: T.nilable(OpenAI::Models::Metadata),
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
              metadata: T.nilable(OpenAI::Models::Metadata),
              name: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::BaseModel
        sig { returns(Symbol) }
        def anchor
        end

        sig { params(_: Symbol).returns(Symbol) }
        def anchor=(_)
        end

        sig { returns(Integer) }
        def days
        end

        sig { params(_: Integer).returns(Integer) }
        def days=(_)
        end

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
