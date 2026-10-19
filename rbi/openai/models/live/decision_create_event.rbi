# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionCreateEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionCreateEvent,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :event_id

        sig { returns(Symbol) }
        attr_accessor :type

        # Evaluate the configured questions using the current conversation and Decision
        # inputs. Reusing an event_id is rejected for the lifetime of the session.
        sig do
          params(

            event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          event_id:,

          type: :"decision.create"
        )
        end

        sig do
          override.returns(
            {event_id: String, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
