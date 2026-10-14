# typed: strong

module OpenAI
  module Models

    module Live

      class SessionRejectParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionRejectParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :session_id

        # SIP rejection status sent to the caller. This field is required.
        sig { returns(Integer) }
        attr_accessor :status_code

        sig do
          params(

            session_id: String,

            status_code: Integer,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          session_id:,

          # SIP rejection status sent to the caller. This field is required.
          status_code:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {session_id: String, status_code: Integer, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
