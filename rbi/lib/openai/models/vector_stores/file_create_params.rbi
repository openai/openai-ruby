# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(String) }
        def file_id
        end

        sig { params(_: String).returns(String) }
        def file_id=(_)
        end

        sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
        def attributes
        end

        sig do
          params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
            .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
        end
        def attributes=(_)
        end

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
            file_id: String,
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy: T.any(
              OpenAI::Models::AutoFileChunkingStrategyParam,
              OpenAI::Models::StaticFileChunkingStrategyObjectParam
            ),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(file_id:, attributes: nil, chunking_strategy: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                file_id: String,
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
            sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
            private def variants
            end
          end
        end
      end
    end
  end
end
