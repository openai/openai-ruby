# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileBatchCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::VectorStores::FileBatchCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard. Keys are strings with a maximum
        # length of 64 characters. Values are strings with a maximum length of 512
        # characters, booleans, or numbers.
        sig do
          returns(
            T.nilable(
              T::Hash[
                Symbol,
                OpenAI::VectorStores::FileBatchCreateParams::Attribute::Variants
              ]
            )
          )
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

        # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
        # the vector store should use. Useful for tools like `file_search` that can access
        # files. If `attributes` or `chunking_strategy` are provided, they will be applied
        # to all files in the batch. Mutually exclusive with `files`.
        sig { returns(T.nilable(T::Array[String])) }
        attr_reader :file_ids

        sig { params(file_ids: T::Array[String]).void }
        attr_writer :file_ids

        # A list of objects that each include a `file_id` plus optional `attributes` or
        # `chunking_strategy`. Use this when you need to override metadata for specific
        # files. The global `attributes` or `chunking_strategy` will be ignored and must
        # be specified for each file. Mutually exclusive with `file_ids`.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::VectorStores::FileBatchCreateParams::File]
            )
          )
        end
        attr_reader :files

        sig do
          params(
            files:
              T::Array[
                OpenAI::VectorStores::FileBatchCreateParams::File::OrHash
              ]
          ).void
        end
        attr_writer :files

        sig do
          params(
            attributes:
              T.nilable(
                T::Hash[
                  Symbol,
                  OpenAI::VectorStores::FileBatchCreateParams::Attribute::Variants
                ]
              ),
            chunking_strategy:
              T.any(
                OpenAI::AutoFileChunkingStrategyParam::OrHash,
                OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
              ),
            file_ids: T::Array[String],
            files:
              T::Array[
                OpenAI::VectorStores::FileBatchCreateParams::File::OrHash
              ],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard. Keys are strings with a maximum
          # length of 64 characters. Values are strings with a maximum length of 512
          # characters, booleans, or numbers.
          attributes: nil,
          # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
          # strategy. Only applicable if `file_ids` is non-empty.
          chunking_strategy: nil,
          # A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that
          # the vector store should use. Useful for tools like `file_search` that can access
          # files. If `attributes` or `chunking_strategy` are provided, they will be applied
          # to all files in the batch. Mutually exclusive with `files`.
          file_ids: nil,
          # A list of objects that each include a `file_id` plus optional `attributes` or
          # `chunking_strategy`. Use this when you need to override metadata for specific
          # files. The global `attributes` or `chunking_strategy` will be ignored and must
          # be specified for each file. Mutually exclusive with `file_ids`.
          files: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              attributes:
                T.nilable(
                  T::Hash[
                    Symbol,
                    OpenAI::VectorStores::FileBatchCreateParams::Attribute::Variants
                  ]
                ),
              chunking_strategy:
                T.any(
                  OpenAI::AutoFileChunkingStrategyParam,
                  OpenAI::StaticFileChunkingStrategyObjectParam
                ),
              file_ids: T::Array[String],
              files:
                T::Array[OpenAI::VectorStores::FileBatchCreateParams::File],
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
                OpenAI::VectorStores::FileBatchCreateParams::Attribute::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class File < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::VectorStores::FileBatchCreateParams::File,
                OpenAI::Internal::AnyHash
              )
            end

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
            returns(
              T.nilable(
                T::Hash[
                  Symbol,
                  OpenAI::VectorStores::FileBatchCreateParams::File::Attribute::Variants
                ]
              )
            )
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
                T.nilable(
                  T::Hash[
                    Symbol,
                    OpenAI::VectorStores::FileBatchCreateParams::File::Attribute::Variants
                  ]
                ),
              chunking_strategy:
                T.any(
                  OpenAI::AutoFileChunkingStrategyParam::OrHash,
                  OpenAI::StaticFileChunkingStrategyObjectParam::OrHash
                )
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
            chunking_strategy: nil
          )
          end

          sig do
            override.returns(
              {
                file_id: String,
                attributes:
                  T.nilable(
                    T::Hash[
                      Symbol,
                      OpenAI::VectorStores::FileBatchCreateParams::File::Attribute::Variants
                    ]
                  ),
                chunking_strategy:
                  T.any(
                    OpenAI::AutoFileChunkingStrategyParam,
                    OpenAI::StaticFileChunkingStrategyObjectParam
                  )
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
                  OpenAI::VectorStores::FileBatchCreateParams::File::Attribute::Variants
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
end
