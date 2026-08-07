# typed: strong
# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.

module OpenAI
  module Models
    class ContentProvenanceCheckCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(
            OpenAI::ContentProvenanceCheckCreateParams,
            OpenAI::Internal::AnyHash
          )
        end

      # The image or audio file to check for supported OpenAI provenance signals.
      sig { returns(OpenAI::Internal::FileInput) }
      attr_accessor :file

      sig do
        params(
          file: OpenAI::Internal::FileInput,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The image or audio file to check for supported OpenAI provenance signals.
        file:,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            file: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end
    end
  end
end
