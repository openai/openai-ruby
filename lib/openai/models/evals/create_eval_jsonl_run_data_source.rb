# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalJSONLRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #
        #   @return [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID]
        required :source, union: -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source }

        # @!attribute type
        #   The type of data source. Always `jsonl`.
        #
        #   @return [Symbol, :jsonl]
        required :type, const: :jsonl

        # @!parse
        #   # A JsonlRunDataSource object with that specifies a JSONL file that matches the
        #   # eval
        #   #
        #   # @param source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID]
        #   # @param type [Symbol, :jsonl]
        #   #
        #   def initialize(source:, type: :jsonl, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # @see OpenAI::Models::Evals::CreateEvalJSONLRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent }

          variant :file_id, -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID }

          class FileContent < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The content of the jsonl file.
            #
            #   @return [Array<OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content>]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content] }

            # @!attribute type
            #   The type of jsonl source. Always `file_content`.
            #
            #   @return [Symbol, :file_content]
            required :type, const: :file_content

            # @!parse
            #   # @param content [Array<OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent::Content>]
            #   # @param type [Symbol, :file_content]
            #   #
            #   def initialize(content:, type: :file_content, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            class Content < OpenAI::Internal::Type::BaseModel
              # @!attribute item
              #
              #   @return [Hash{Symbol=>Object}]
              required :item, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

              # @!attribute [r] sample
              #
              #   @return [Hash{Symbol=>Object}, nil]
              optional :sample, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

              # @!parse
              #   # @return [Hash{Symbol=>Object}]
              #   attr_writer :sample

              # @!parse
              #   # @param item [Hash{Symbol=>Object}]
              #   # @param sample [Hash{Symbol=>Object}]
              #   #
              #   def initialize(item:, sample: nil, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
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

            # @!parse
            #   # @param id [String]
            #   # @param type [Symbol, :file_id]
            #   #
            #   def initialize(id:, type: :file_id, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end

          # @!parse
          #   # @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalJSONLRunDataSource::Source::FileID)]
          #   def self.variants; end
        end
      end
    end
  end
end
