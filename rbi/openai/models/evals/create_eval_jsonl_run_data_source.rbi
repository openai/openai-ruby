# typed: strong

module OpenAI
  module Models
    module Evals
      class CreateEvalJSONLRunDataSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Internal::AnyHash
            )
          end

        # Determines what populates the `item` namespace in the data source.
        sig do
          returns(
            T.any(
              OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent,
              OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileID
            )
          )
        end
        attr_accessor :source

        # The type of data source. Always `jsonl`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A JsonlRunDataSource object with that specifies a JSONL file that matches the
        # eval
        sig do
          params(
            source:
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::OrHash,
                OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileID::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Determines what populates the `item` namespace in the data source.
          source:,
          # The type of data source. Always `jsonl`.
          type: :jsonl
        )
        end

        sig do
          override.returns(
            {
              source:
                T.any(
                  OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent,
                  OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileID
                ),
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # Determines what populates the `item` namespace in the data source.
        module Source
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent,
                OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileID
              )
            end

          class FileContent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The content of the jsonl file.
            sig do
              returns(
                T::Array[
                  OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content
                ]
              )
            end
            attr_accessor :content

            # The type of jsonl source. Always `file_content`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                content:
                  T::Array[
                    OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content::OrHash
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The content of the jsonl file.
              content:,
              # The type of jsonl source. Always `file_content`.
              type: :file_content
            )
            end

            sig do
              override.returns(
                {
                  content:
                    T::Array[
                      OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class Content < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(T::Hash[Symbol, T.anything]) }
              attr_accessor :item

              sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
              attr_reader :sample

              sig { params(sample: T::Hash[Symbol, T.anything]).void }
              attr_writer :sample

              sig do
                params(
                  item: T::Hash[Symbol, T.anything],
                  sample: T::Hash[Symbol, T.anything]
                ).returns(T.attached_class)
              end
              def self.new(item:, sample: nil)
              end

              sig do
                override.returns(
                  {
                    item: T::Hash[Symbol, T.anything],
                    sample: T::Hash[Symbol, T.anything]
                  }
                )
              end
              def to_hash
              end
            end
          end

          class FileID < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileID,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier of the file.
            sig { returns(String) }
            attr_accessor :id

            # The type of jsonl source. Always `file_id`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { params(id: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The identifier of the file.
              id:,
              # The type of jsonl source. Always `file_id`.
              type: :file_id
            )
            end

            sig { override.returns({ id: String, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::Variants
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
