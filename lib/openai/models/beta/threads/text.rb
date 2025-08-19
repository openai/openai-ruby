# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute annotations
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::FileCitationAnnotation, OpenAI::Models::Beta::Threads::FilePathAnnotation>]
          required :annotations, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Threads::Annotation] }

          # @!attribute value
          #   The data that makes up the text.
          #
          #   @return [String]
          required :value, String

          # @!method initialize(annotations:, value:)
          #   @param annotations [Array<OpenAI::Models::Beta::Threads::FileCitationAnnotation, OpenAI::Models::Beta::Threads::FilePathAnnotation>]
          #
          #   @param value [String] The data that makes up the text.
        end
      end
    end
  end
end
