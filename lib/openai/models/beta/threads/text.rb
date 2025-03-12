# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class Text < OpenAI::BaseModel
          # @!attribute annotations
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::FileCitationAnnotation, OpenAI::Models::Beta::Threads::FilePathAnnotation>]
          required :annotations, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::Annotation] }

          # @!attribute value
          #   The data that makes up the text.
          #
          #   @return [String]
          required :value, String

          # @!parse
          #   # @param annotations [Array<OpenAI::Models::Beta::Threads::FileCitationAnnotation, OpenAI::Models::Beta::Threads::FilePathAnnotation>]
          #   # @param value [String]
          #   #
          #   def initialize(annotations:, value:, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
