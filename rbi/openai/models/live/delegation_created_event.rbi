# typed: strong

module OpenAI
  module Models

    module Live

      class DelegationCreatedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DelegationCreatedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The delegated work identifier and destination. This object contains metadata,
        # not the task text.
        sig { returns(OpenAI::Live::DelegationCreatedEvent::Delegation) }
        attr_reader :delegation

        sig { params(delegation: OpenAI::Live::DelegationCreatedEvent::Delegation::OrHash).void }
        attr_writer :delegation

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The position on the Live session timeline where the delegation was created, in
        # milliseconds from the beginning of the session.
        sig { returns(Integer) }
        attr_accessor :offset_ms

        # The event type, always `session.delegation.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # Returned when the Live model delegates work to your application or a Responses
        # backend. Contains delegation metadata and the position on the session timeline
        # where the work was delegated.
        sig do
          params(

            delegation: OpenAI::Live::DelegationCreatedEvent::Delegation::OrHash,

            event_id: String,

            offset_ms: Integer,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The delegated work identifier and destination. This object contains metadata,
          # not the task text.
          delegation:,

          # The unique ID of the Live server event.
          event_id:,

          # The position on the Live session timeline where the delegation was created, in
          # milliseconds from the beginning of the session.
          offset_ms:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `session.delegation.created`.

          type: :"session.delegation.created"
        )
        end

        sig do
          override.returns(
            {
              delegation: OpenAI::Live::DelegationCreatedEvent::Delegation,
              event_id: String,
              offset_ms: Integer,
              type: Symbol,
              client_event_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        class Delegation < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DelegationCreatedEvent::Delegation,
              OpenAI::Internal::AnyHash
            )
          end

          # The unique ID of the delegation. Use this as delegation_id when replying to
          # client-owned work or correlating Responses events.
          sig { returns(String) }
          attr_accessor :id

          # Where the Live model delegated the work: `client` for your application, or
          # `responses` for the configured Responses backend.
          sig { returns(OpenAI::Live::DelegationCreatedEvent::Delegation::Target::OrSymbol) }
          attr_accessor :target

          # The object type, always `delegation`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The ID of the Responses API response associated with a Responses delegation.
          # Omitted for client delegations.
          sig { returns(T.nilable(String)) }
          attr_reader :response_id

          sig { params(response_id: String).void }
          attr_writer :response_id

          # The delegated work identifier and destination. This object contains metadata,
          # not the task text.
          sig do
            params(

              id: String,

              target: OpenAI::Live::DelegationCreatedEvent::Delegation::Target::OrSymbol,

              response_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The unique ID of the delegation. Use this as delegation_id when replying to
            # client-owned work or correlating Responses events.
            id:,

            # Where the Live model delegated the work: `client` for your application, or
            # `responses` for the configured Responses backend.
            target:,

            # The ID of the Responses API response associated with a Responses delegation.
            # Omitted for client delegations.
            response_id: nil,

            # The object type, always `delegation`.

            type: :delegation
          )
          end

          sig do
            override.returns(
              {
                id: String,
                target: OpenAI::Live::DelegationCreatedEvent::Delegation::Target::OrSymbol,
                type: Symbol,
                response_id: T.nilable(String)
              }
            )
          end
          def to_hash
          end

          # Where the Live model delegated the work: `client` for your application, or
          # `responses` for the configured Responses backend.
          module Target
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { OpenAI::Live::DelegationCreatedEvent::Delegation::Target::TaggedSymbol }

            sig { override.returns(T::Array[OpenAI::Live::DelegationCreatedEvent::Delegation::Target::Variants]) }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Live::DelegationCreatedEvent::Delegation::Target)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CLIENT = T.let(:client, OpenAI::Live::DelegationCreatedEvent::Delegation::Target::TaggedSymbol)
            RESPONSES = T.let(:responses, OpenAI::Live::DelegationCreatedEvent::Delegation::Target::TaggedSymbol)

          end
        end

      end

    end

  end
end
