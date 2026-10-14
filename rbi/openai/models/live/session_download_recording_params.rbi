# typed: strong

module OpenAI
  module Models

    module Live

      class SessionDownloadRecordingParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionDownloadRecordingParams,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the stored Live session to download. Use the session ID returned when
        # the session started with storage enabled.
        sig { returns(String) }
        attr_accessor :session_id

        sig do
          params(

            session_id: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the stored Live session to download. Use the session ID returned when
          # the session started with storage enabled.
          session_id:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {session_id: String, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
