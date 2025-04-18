# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] annotations
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation>, nil]
          optional :annotations,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::AnnotationDelta] }

          # @!parse
          #   # @return [Array<OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation>]
          #   attr_writer :annotations

          # @!attribute [r] value
          #   The data that makes up the text.
          #
          #   @return [String, nil]
          optional :value, String

          # @!parse
          #   # @return [String]
          #   attr_writer :value

          # @!method initialize(annotations: nil, value: nil)
          #   @param annotations [Array<OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation>]
          #   @param value [String]
        end
      end
    end
  end
end
