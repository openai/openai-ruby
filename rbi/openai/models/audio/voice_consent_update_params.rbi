# typed: strong

module OpenAI
  module Models

    module Audio

      class VoiceConsentUpdateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::VoiceConsentUpdateParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :consent_id

        # The updated label for this consent recording.
        sig { returns(String) }
        attr_accessor :name

        sig do
          params(

            consent_id: String,

            name: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          consent_id:,

          # The updated label for this consent recording.
          name:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {consent_id: String, name: String, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
