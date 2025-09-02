# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeError < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::RealtimeError, OpenAI::Internal::AnyHash)
          end

        # A human-readable error message.
        sig { returns(String) }
        attr_accessor :message

        # The type of error (e.g., "invalid_request_error", "server_error").
        sig { returns(String) }
        attr_accessor :type

        # Error code, if any.
        sig { returns(T.nilable(String)) }
        attr_accessor :code

        # The event_id of the client event that caused the error, if applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Parameter related to the error, if any.
        sig { returns(T.nilable(String)) }
        attr_accessor :param

        # Details of the error.
        sig do
          params(
            message: String,
            type: String,
            code: T.nilable(String),
            event_id: T.nilable(String),
            param: T.nilable(String)
          ).returns(T.attached_class)
        end
        def self.new(
          # A human-readable error message.
          message:,
          # The type of error (e.g., "invalid_request_error", "server_error").
          type:,
          # Error code, if any.
          code: nil,
          # The event_id of the client event that caused the error, if applicable.
          event_id: nil,
          # Parameter related to the error, if any.
          param: nil
        )
        end

        sig do
          override.returns(
            {
              message: String,
              type: String,
              code: T.nilable(String),
              event_id: T.nilable(String),
              param: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
