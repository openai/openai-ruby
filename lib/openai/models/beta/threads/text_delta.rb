# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDelta < OpenAI::BaseModel
          # @!attribute [r] annotations
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation>, nil]
          optional :annotations, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::AnnotationDelta] }

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

          # @!parse
          #   # @param annotations [Array<OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation>]
          #   # @param value [String]
          #   #
          #   def initialize(annotations: nil, value: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
