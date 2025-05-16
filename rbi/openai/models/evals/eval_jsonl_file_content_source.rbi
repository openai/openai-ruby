# typed: strong

module OpenAI
  module Models
    EvalJSONLFileContentSource = Evals::EvalJSONLFileContentSource

    module Evals
      class EvalJSONLFileContentSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Evals::EvalJSONLFileContentSource,
              OpenAI::Internal::AnyHash
            )
          end

        # The content of the jsonl file.
        sig do
          returns(T::Array[OpenAI::Evals::EvalJSONLFileContentSource::Content])
        end
        attr_accessor :content

        # The type of jsonl source. Always `file_content`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            content:
              T::Array[
                OpenAI::Evals::EvalJSONLFileContentSource::Content::OrHash
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
                T::Array[OpenAI::Evals::EvalJSONLFileContentSource::Content],
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
                OpenAI::Evals::EvalJSONLFileContentSource::Content,
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
    end
  end
end
