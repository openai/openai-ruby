# typed: strong

module OpenAI
  module Models
    module Realtime
      class CallRejectParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::CallRejectParams, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :call_id

        # SIP response code to send back to the caller. Defaults to `603` (Decline) when
        # omitted.
        sig { returns(T.nilable(Integer)) }
        attr_reader :status_code

        sig { params(status_code: Integer).void }
        attr_writer :status_code

        sig do
          params(
            call_id: String,
            status_code: Integer,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          call_id:,
          # SIP response code to send back to the caller. Defaults to `603` (Decline) when
          # omitted.
          status_code: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              call_id: String,
              status_code: Integer,
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
