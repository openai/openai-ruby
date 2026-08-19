# typed: strong

module OpenAI
  module Models

    module Webhooks

      class ResponseCompletedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::ResponseCompletedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the model response was completed.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::ResponseCompletedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::ResponseCompletedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The type of the event. Always `response.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig { returns(T.nilable(OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object::TaggedSymbol)) }
        attr_reader :object

        sig { params(object: OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object::OrSymbol).void }
        attr_writer :object

        # Sent when a background response has been completed.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::ResponseCompletedWebhookEvent::Data::OrHash,

            object: OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object::OrSymbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          id:,

          # The Unix timestamp (in seconds) of when the model response was completed.
          created_at:,

          # Event data payload.
          data:,

          # The object of the event. Always `event`.
          object: nil,

          # The type of the event. Always `response.completed`.

          type: :"response.completed"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::ResponseCompletedWebhookEvent::Data,
              type: Symbol,
              object: OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Webhooks::ResponseCompletedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The unique ID of the model response.
          sig { returns(String) }
          attr_accessor :id

          # Event data payload.
          sig do
            params(

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The unique ID of the model response.

            id:
          )
          end

          sig do
            override.returns(
              {id: String}
            )
          end
          def to_hash
          end

        end

        # The object of the event. Always `event`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT = T.let(:event, OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Webhooks::ResponseCompletedWebhookEvent::Object::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
