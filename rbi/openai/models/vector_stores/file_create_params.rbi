# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # A [File](https://platform.openai.com/docs/api-reference/files) ID that the
        # vector store should use. Useful for tools like `file_search` that can access
        # files.
        sig { returns(String) }
        attr_accessor :file_id

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard. Keys are strings with a maximum
        # length of 64 characters. Values are strings with a maximum length of 512
        # characters, booleans, or numbers.
        sig do
          returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
        end
        attr_accessor :attributes

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

        sig do
          params(
            file_id: String,
            attributes:
              T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            chunking_strategy:
              T.any(
                OpenAI::AutoFileChunkingStrategyParam::OrHash,
                OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # A [File](https://platform.openai.com/docs/api-reference/files) ID that the
          # vector store should use. Useful for tools like `file_search` that can access
          # files.
          file_id:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard. Keys are strings with a maximum
          # length of 64 characters. Values are strings with a maximum length of 512
          # characters, booleans, or numbers.
          attributes: nil,
          # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          # strategy. Only applicable if `file_ids` is non-empty.
          chunking_strategy: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              file_id: String,
              attributes:
                T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
              chunking_strategy:
                T.any(
                  OpenAI::AutoFileChunkingStrategyParam,
                  OpenAI::StaticFileChunkingStrategyObjectParam
                ),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        module Attribute
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, Float, T::Boolean) }

          sig do
            override.returns(
              T::Array[
                OpenAI::VectorStores::FileCreateParams::Attribute::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
