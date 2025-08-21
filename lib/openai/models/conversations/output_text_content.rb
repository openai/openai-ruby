# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class OutputTextContent < OpenAI::Internal::Type::BaseModel
        # @!attribute annotations
        #   The annotations of the text output.
        #
        #   @return [Array<OpenAI::Models::Conversations::FileCitationBody, OpenAI::Models::Conversations::URLCitationBody, OpenAI::Models::Conversations::ContainerFileCitationBody>]
        required :annotations,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::OutputTextContent::Annotation] }

        # @!attribute text
        #   The text output from the model.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the output text. Always `output_text`.
        #
        #   @return [Symbol, :output_text]
        required :type, const: :output_text

        # @!attribute logprobs
        #
        #   @return [Array<OpenAI::Models::Conversations::LobProb>, nil]
        optional :logprobs, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::LobProb] }

        # @!method initialize(annotations:, text:, logprobs: nil, type: :output_text)
        #   @param annotations [Array<OpenAI::Models::Conversations::FileCitationBody, OpenAI::Models::Conversations::URLCitationBody, OpenAI::Models::Conversations::ContainerFileCitationBody>] The annotations of the text output.
        #
        #   @param text [String] The text output from the model.
        #
        #   @param logprobs [Array<OpenAI::Models::Conversations::LobProb>]
        #
        #   @param type [Symbol, :output_text] The type of the output text. Always `output_text`.

        module Annotation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_citation, -> { OpenAI::Conversations::FileCitationBody }

          variant :url_citation, -> { OpenAI::Conversations::URLCitationBody }

          variant :container_file_citation, -> { OpenAI::Conversations::ContainerFileCitationBody }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Conversations::FileCitationBody, OpenAI::Models::Conversations::URLCitationBody, OpenAI::Models::Conversations::ContainerFileCitationBody)]
        end
      end
    end
  end
end
