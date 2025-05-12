# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputMessage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseOutputMessage,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the output message.
        sig { returns(String) }
        attr_accessor :id

        # The content of the output message.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::ResponseOutputText,
                OpenAI::Responses::ResponseOutputRefusal
              )
            ]
          )
        end
        attr_accessor :content

        # The role of the output message. Always `assistant`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        sig do
          returns(OpenAI::Responses::ResponseOutputMessage::Status::OrSymbol)
        end
        attr_accessor :status

        # The type of the output message. Always `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An output message from the model.
        sig do
          params(
            id: String,
            content:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseOutputText::OrHash,
                  OpenAI::Responses::ResponseOutputRefusal::OrHash
                )
              ],
            status: OpenAI::Responses::ResponseOutputMessage::Status::OrSymbol,
            role: Symbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the output message.
          id:,
          # The content of the output message.
          content:,
          # The status of the message input. One of `in_progress`, `completed`, or
          # `incomplete`. Populated when input items are returned via API.
          status:,
          # The role of the output message. Always `assistant`.
          role: :assistant,
          # The type of the output message. Always `message`.
          type: :message
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content:
                T::Array[
                  T.any(
                    OpenAI::Responses::ResponseOutputText,
                    OpenAI::Responses::ResponseOutputRefusal
                  )
                ],
              role: Symbol,
              status:
                OpenAI::Responses::ResponseOutputMessage::Status::OrSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # A text output from the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseOutputText,
                OpenAI::Responses::ResponseOutputRefusal
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseOutputMessage::Content::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseOutputMessage::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseOutputMessage::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseOutputMessage::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseOutputMessage::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseOutputMessage::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
