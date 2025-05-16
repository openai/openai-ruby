# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class EvalJSONLFileContentSource < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The content of the jsonl file.
        #
        #   @return [Array<OpenAI::Evals::EvalJSONLFileContentSource::Content>]
        required :content,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Evals::EvalJSONLFileContentSource::Content] }

        # @!attribute type
        #   The type of jsonl source. Always `file_content`.
        #
        #   @return [Symbol, :file_content]
        required :type, const: :file_content

        # @!method initialize(content:, type: :file_content)
        #   @param content [Array<OpenAI::Evals::EvalJSONLFileContentSource::Content>] The content of the jsonl file.
        #
        #   @param type [Symbol, :file_content] The type of jsonl source. Always `file_content`.

        class Content < OpenAI::Internal::Type::BaseModel
          # @!attribute item
          #
          #   @return [Hash{Symbol=>Object}]
          required :item, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute sample
          #
          #   @return [Hash{Symbol=>Object}, nil]
          optional :sample, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!method initialize(item:, sample: nil)
          #   @param item [Hash{Symbol=>Object}]
          #   @param sample [Hash{Symbol=>Object}]
        end
      end
    end

    EvalJSONLFileContentSource = Evals::EvalJSONLFileContentSource
  end
end
