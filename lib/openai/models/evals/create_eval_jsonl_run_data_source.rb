# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalJSONLRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #
        #   @return [OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource]
        required :source, union: -> { OpenAI::Evals::CreateEvalJSONLRunDataSource::Source }

        # @!attribute type
        #   The type of data source. Always `jsonl`.
        #
        #   @return [Symbol, :jsonl]
        required :type, const: :jsonl

        # @!method initialize(source:, type: :jsonl)
        #   A JsonlRunDataSource object with that specifies a JSONL file that matches the
        #   eval
        #
        #   @param source [OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource]
        #
        #   @param type [Symbol, :jsonl] The type of data source. Always `jsonl`.

        # @see OpenAI::Evals::CreateEvalJSONLRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Evals::EvalJSONLFileContentSource }

          variant :file_id, -> { OpenAI::Evals::EvalJSONLFileIDSource }

          # @!method self.variants
          #   @return [Array(OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource)
            end
          end
        end
      end
    end
  end
end
