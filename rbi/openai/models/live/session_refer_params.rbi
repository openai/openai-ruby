# typed: strong

module OpenAI
  module Models

    module Live

      class SessionReferParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionReferParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :session_id

        # Nonblank URI for the SIP Refer-To header, such as tel:+14155550123 or
        # sip:agent@example.com.
        sig { returns(String) }
        attr_accessor :target_uri

        sig do
          params(

            session_id: String,

            target_uri: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          session_id:,

          # Nonblank URI for the SIP Refer-To header, such as tel:+14155550123 or
          # sip:agent@example.com.
          target_uri:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {session_id: String, target_uri: String, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
