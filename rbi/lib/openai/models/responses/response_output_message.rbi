# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputMessage < OpenAI::BaseModel
        # The unique ID of the output message.
        sig { returns(String) }
        attr_accessor :id

        # The content of the output message.
        sig do
          returns(
            T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
          )
        end
        attr_accessor :content

        # The role of the output message. Always `assistant`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        sig { returns(OpenAI::Models::Responses::ResponseOutputMessage::Status::OrSymbol) }
        attr_accessor :status

        # The type of the output message. Always `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An output message from the model.
        sig do
          params(
            id: String,
            content: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseOutputText,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Responses::ResponseOutputRefusal
            )
            ],
            status: OpenAI::Models::Responses::ResponseOutputMessage::Status::OrSymbol,
            role: Symbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, content:, status:, role: :assistant, type: :message)
        end

        sig do
          override
            .returns(
              {
                id: String,
                content: T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)],
                role: Symbol,
                status: OpenAI::Models::Responses::ResponseOutputMessage::Status::OrSymbol,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # A text output from the model.
        module Content
          extend OpenAI::Union

          sig do
            override
              .returns([OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal])
          end
          def self.variants
          end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseOutputMessage::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseOutputMessage::Status::TaggedSymbol) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Responses::ResponseOutputMessage::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseOutputMessage::Status::TaggedSymbol)
          INCOMPLETE = T.let(:incomplete, OpenAI::Models::Responses::ResponseOutputMessage::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseOutputMessage::Status::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
