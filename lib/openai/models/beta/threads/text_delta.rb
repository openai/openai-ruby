# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute annotations
          #
          #   @return [Array<OpenAI::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Beta::Threads::FilePathDeltaAnnotation>, nil]
          optional :annotations,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Threads::AnnotationDelta] }

          # @!attribute value
          #   The data that makes up the text.
          #
          #   @return [String, nil]
          optional :value, String

          # @!method initialize(annotations: nil, value: nil)
          #   @param annotations [Array<OpenAI::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Beta::Threads::FilePathDeltaAnnotation>]
          #
          #   @param value [String] The data that makes up the text.
        end
      end
    end
  end
end
