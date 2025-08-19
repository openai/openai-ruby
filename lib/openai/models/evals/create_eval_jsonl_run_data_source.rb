# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalJSONLRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #   Determines what populates the `item` namespace in the data source.
        #
        #   @return [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID]
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
        #   @param source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID] Determines what populates the `item` namespace in the data source.
        #
        #   @param type [Symbol, :jsonl] The type of data source. Always `jsonl`.

        # Determines what populates the `item` namespace in the data source.
        #
        # @see OpenAI::Models::Evals::CreateEvalJSONLRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent }

          variant :file_id, -> { OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileID }

          class FileContent < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The content of the jsonl file.
            #
            #   @return [Array<OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content>]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content] }

            # @!attribute type
            #   The type of jsonl source. Always `file_content`.
            #
            #   @return [Symbol, :file_content]
            required :type, const: :file_content

            # @!method initialize(content:, type: :file_content)
            #   @param content [Array<OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content>] The content of the jsonl file.
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

          class FileID < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier of the file.
            #
            #   @return [String]
            required :id, String

            # @!attribute type
            #   The type of jsonl source. Always `file_id`.
            #
            #   @return [Symbol, :file_id]
            required :type, const: :file_id

            # @!method initialize(id:, type: :file_id)
            #   @param id [String] The identifier of the file.
            #
            #   @param type [Symbol, :file_id] The type of jsonl source. Always `file_id`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID)]
        end
      end
    end
  end
end
