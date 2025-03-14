# typed: strong

module OpenAI
  module Models
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

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters, booleans, or numbers.
        sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
        def attributes
        end

        sig do
          params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
            .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
        end
        def attributes=(_)
        end

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

        sig do
          params(
            file_ids: T::Array[String],
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            ),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(file_ids:, attributes: nil, chunking_strategy: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                file_ids: T::Array[String],
                attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
                chunking_strategy: T.any(
                  OpenAI::Models::AutoFileChunkingStrategyParam,
                  OpenAI::Models::StaticFileChunkingStrategyObjectParam
                ),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Attribute < OpenAI::Union
          abstract!

          class << self
            # @api private
            sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
            private def variants
            end
          end
        end
      end
    end
  end
end
