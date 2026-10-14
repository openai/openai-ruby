# typed: strong

module OpenAI
  module Models

    module Live

      class Error < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::Error,
            OpenAI::Internal::AnyHash
          )
        end

        # A machine-readable code identifying the Live error, such as `unknown_parameter`.
        sig { returns(String) }
        attr_accessor :code

        # A human-readable explanation of the Live error.
        sig { returns(String) }
        attr_accessor :message

        # The category of error, such as `invalid_request_error` for an invalid Live
        # client command.
        sig { returns(String) }
        attr_accessor :type

        # The event_id of the client command that caused the error, when supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # The parameter that caused the error, when applicable, such as `session.voice`.
        sig { returns(T.nilable(String)) }
        attr_reader :param

        sig { params(param: String).void }
        attr_writer :param

        # Details of an error encountered by the Live session, including the affected
        # parameter or client command when available.
        sig do
          params(

            code: String,

            message: String,

            type: String,

            client_event_id: String,

            param: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A machine-readable code identifying the Live error, such as `unknown_parameter`.
          code:,

          # A human-readable explanation of the Live error.
          message:,

          # The category of error, such as `invalid_request_error` for an invalid Live
          # client command.
          type:,

          # The event_id of the client command that caused the error, when supplied.
          client_event_id: nil,

          # The parameter that caused the error, when applicable, such as `session.voice`.

          param: nil
        )
        end

        sig do
          override.returns(
            {code: String, message: String, type: String, client_event_id: String, param: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
