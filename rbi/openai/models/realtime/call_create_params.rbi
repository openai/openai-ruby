# typed: strong

module OpenAI
  module Models
    module Realtime
      class CallCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::CallCreateParams, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :sdp

        sig do
          returns(T.nilable(OpenAI::Realtime::RealtimeSessionCreateRequest))
        end
        attr_accessor :session

        sig do
          params(
            sdp: String,
            session:
              T.nilable(OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(sdp:, session: nil, request_options: {})
        end

        sig do
          override.returns(
            {
              sdp: String,
              session:
                T.nilable(OpenAI::Realtime::RealtimeSessionCreateRequest),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
