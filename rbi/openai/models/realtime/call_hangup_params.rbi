# typed: strong

module OpenAI
  module Models
    module Realtime
      class CallHangupParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::CallHangupParams, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :call_id

        sig do
          params(
            call_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(call_id:, request_options: {})
        end

        sig do
          override.returns(
            { call_id: String, request_options: OpenAI::RequestOptions }
          )
        end
        def to_hash
        end
      end
    end
  end
end
