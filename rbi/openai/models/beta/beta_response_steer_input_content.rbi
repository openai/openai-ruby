# typed: strong

module OpenAI
  module Models

    BetaResponseSteerInputContent = Beta::BetaResponseSteerInputContent

    module Beta

      # A piece of message content, such as text, an image, or a file.
      module BetaResponseSteerInputContent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseInputTextContent,
            OpenAI::Beta::BetaResponseInputImageContent,
            OpenAI::Beta::BetaResponseInputFileContent
          )
        end

        sig { override.returns(T::Array[OpenAI::Beta::BetaResponseSteerInputContent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
