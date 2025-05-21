# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseErrorEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseErrorEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The error code.
        sig { returns(T.nilable(String)) }
        attr_accessor :code

        # The error message.
        sig { returns(String) }
        attr_accessor :message

        # The error parameter.
        sig { returns(T.nilable(String)) }
        attr_accessor :param

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `error`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an error occurs.
        sig do
          params(
            code: T.nilable(String),
            message: String,
            param: T.nilable(String),
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The error code.
          code:,
          # The error message.
          message:,
          # The error parameter.
          param:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `error`.
          type: :error
        )
        end

        sig do
          override.returns(
            {
              code: T.nilable(String),
              message: String,
              param: T.nilable(String),
              sequence_number: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
