# typed: strong

module OpenAI
  module Models
    module Realtime
      class CallAcceptParams < OpenAI::Models::Realtime::RealtimeSessionCreateRequest
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::CallAcceptParams, OpenAI::Internal::AnyHash)
          end

        sig do
          params(request_options: OpenAI::RequestOptions::OrHash).returns(
            T.attached_class
          )
        end
        def self.new(request_options: {})
        end

        sig { override.returns({ request_options: OpenAI::RequestOptions }) }
        def to_hash
        end
      end
    end
  end
end
