# typed: strong

module OpenAI
  module Models

    module Webhooks

      class EvalRunFailedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::EvalRunFailedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the eval run failed.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::EvalRunFailedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::EvalRunFailedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The type of the event. Always `eval.run.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig { returns(T.nilable(OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object::TaggedSymbol)) }
        attr_reader :object

        sig { params(object: OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object::OrSymbol).void }
        attr_writer :object

        # Sent when an eval run has failed.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::EvalRunFailedWebhookEvent::Data::OrHash,

            object: OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object::OrSymbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          id:,

          # The Unix timestamp (in seconds) of when the eval run failed.
          created_at:,

          # Event data payload.
          data:,

          # The object of the event. Always `event`.
          object: nil,

          # The type of the event. Always `eval.run.failed`.

          type: :"eval.run.failed"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::EvalRunFailedWebhookEvent::Data,
              type: Symbol,
              object: OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Webhooks::EvalRunFailedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The unique ID of the eval run.
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

            # The unique ID of the eval run.

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

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT = T.let(:event, OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Webhooks::EvalRunFailedWebhookEvent::Object::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
