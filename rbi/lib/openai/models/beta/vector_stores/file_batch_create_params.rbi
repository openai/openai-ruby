# typed: strong

module OpenAI
  module Models
    module Beta
      module VectorStores
        class FileBatchCreateParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
          #   the vector store should use. Useful for tools like `file_search` that can access
          #   files.
          sig { returns(T::Array[String]) }
          def file_ids
          end

          sig { params(_: T::Array[String]).returns(T::Array[String]) }
          def file_ids=(_)
          end

          # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          #   strategy. Only applicable if `file_ids` is non-empty.
          sig do
            returns(
              T.nilable(
                T.any(
                  OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
                  OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
                )
              )
            )
          end
          def chunking_strategy
          end

          sig do
            params(
              _: T.any(
                OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
                OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
              )
            )
              .returns(
                T.any(
                  OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
                  OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
                )
              )
          end
          def chunking_strategy=(_)
          end

          sig do
            params(
              file_ids: T::Array[String],
              chunking_strategy: T.any(
                OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
                OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
              ),
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
            )
              .returns(T.attached_class)
          end
          def self.new(file_ids:, chunking_strategy: nil, request_options: {})
          end

          sig do
            override
              .returns(
                {
                  file_ids: T::Array[String],
                  chunking_strategy: T.any(
                    OpenAI::Models::Beta::AutoFileChunkingStrategyParam,
                    OpenAI::Models::Beta::StaticFileChunkingStrategyObjectParam
                  ),
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end
        end
      end
    end
  end
end
