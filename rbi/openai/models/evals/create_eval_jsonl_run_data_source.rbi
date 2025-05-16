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

        sig do
          returns(
            T.any(
              OpenAI::Evals::EvalJSONLFileContentSource,
              OpenAI::Evals::EvalJSONLFileIDSource
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
                OpenAI::Evals::EvalJSONLFileContentSource::OrHash,
                OpenAI::Evals::EvalJSONLFileIDSource::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
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
                  OpenAI::Evals::EvalJSONLFileContentSource,
                  OpenAI::Evals::EvalJSONLFileIDSource
                ),
              type: Symbol
            }
          )
        end
        def to_hash
        end

        module Source
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource,
                OpenAI::Evals::EvalJSONLFileIDSource
              )
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
