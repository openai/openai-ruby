# typed: strong

module OpenAI
  module Models

    module Audio

      class VoiceConsentRetrieveParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::VoiceConsentRetrieveParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :consent_id

        sig do
          params(

            consent_id: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          consent_id:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {consent_id: String, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
