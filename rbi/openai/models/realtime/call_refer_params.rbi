# typed: strong

module OpenAI
  module Models
    module Realtime
      class CallReferParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::CallReferParams, OpenAI::Internal::AnyHash)
          end

        # URI that should appear in the SIP Refer-To header. Supports values like
        # `tel:+14155550123` or `sip:agent@example.com`.
        sig { returns(String) }
        attr_accessor :target_uri

        sig do
          params(
            target_uri: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # URI that should appear in the SIP Refer-To header. Supports values like
          # `tel:+14155550123` or `sip:agent@example.com`.
          target_uri:,
          request_options: {}
        )
        end

        sig do
          override.returns(
            { target_uri: String, request_options: OpenAI::RequestOptions }
          )
        end
        def to_hash
        end
      end
    end
  end
end
