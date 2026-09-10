# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A plaintext or encrypted content part exchanged between agents.
      module AgentContent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A text content part produced by the agent.
        variant :output_text, -> { OpenAI::Beta::OutputText }

        # Encrypted content exchanged between agents.
        variant :encrypted_content, -> { OpenAI::Beta::AgentContent::EncryptedContent }

        class EncryptedContent < OpenAI::Internal::Type::BaseModel
          # @!attribute encrypted_content
          #   The encrypted content payload.
          #
          #   @return [String]
          required :encrypted_content, String

          # @!attribute type
          #   The content type. Always `encrypted_content`.
          #
          #   @return [Symbol, :encrypted_content]
          required :type, const: :encrypted_content

          # @!method initialize(encrypted_content:, type: :encrypted_content)
          #   Encrypted content exchanged between agents.
          #
          #   @param encrypted_content [String]
          #     The encrypted content payload.
          #
          #   @param type [Symbol, :encrypted_content]
          #     The content type. Always `encrypted_content`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent)]
      end
    end
  end
end
