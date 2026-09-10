# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DelegationCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delegation
        #   The delegated work identifier and destination. This object contains metadata,
        #   not the task text.
        #
        #   @return [OpenAI::Models::Live::DelegationCreatedEvent::Delegation]
        required :delegation, -> { OpenAI::Live::DelegationCreatedEvent::Delegation }

        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute offset_ms
        #   The position on the Live session timeline where the delegation was created, in
        #   milliseconds from the beginning of the session.
        #
        #   @return [Integer]
        required :offset_ms, Integer

        # @!attribute type
        #   The event type, always `session.delegation.created`.
        #
        #   @return [Symbol, :"session.delegation.created"]
        required :type, const: :"session.delegation.created"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(delegation:, event_id:, offset_ms:, client_event_id: nil, type: :"session.delegation.created")
        #   Returned when the Live model delegates work to your application or a Responses
        #   backend. Contains delegation metadata and the position on the session timeline
        #   where the work was delegated.
        #
        #   @param delegation [OpenAI::Models::Live::DelegationCreatedEvent::Delegation]
        #     The delegated work identifier and destination. This object contains metadata,
        #     not the task text.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param offset_ms [Integer]
        #     The position on the Live session timeline where the delegation was created, in
        #     milliseconds from the beginning of the session.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.delegation.created"]
        #     The event type, always `session.delegation.created`.

        # @see OpenAI::Models::Live::DelegationCreatedEvent#delegation
        class Delegation < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the delegation. Use this as delegation_id when replying to
          #   client-owned work or correlating Responses events.
          #
          #   @return [String]
          required :id, String

          # @!attribute target
          #   Where the Live model delegated the work: `client` for your application, or
          #   `responses` for the configured Responses backend.
          #
          #   @return [Symbol, OpenAI::Models::Live::DelegationCreatedEvent::Delegation::Target]
          required :target, union: -> { OpenAI::Live::DelegationCreatedEvent::Delegation::Target }

          # @!attribute type
          #   The object type, always `delegation`.
          #
          #   @return [Symbol, :delegation]
          required :type, const: :delegation

          # @!attribute response_id
          #   The ID of the Responses API response associated with a Responses delegation.
          #   Omitted for client delegations.
          #
          #   @return [String, nil]
          optional :response_id, String

          # @!method initialize(id:, target:, response_id: nil, type: :delegation)
          #   The delegated work identifier and destination. This object contains metadata,
          #   not the task text.
          #
          #   @param id [String]
          #     The unique ID of the delegation. Use this as delegation_id when replying to
          #     client-owned work or correlating Responses events.
          #
          #   @param target [Symbol, OpenAI::Models::Live::DelegationCreatedEvent::Delegation::Target]
          #     Where the Live model delegated the work: `client` for your application, or
          #     `responses` for the configured Responses backend.
          #
          #   @param response_id [String]
          #     The ID of the Responses API response associated with a Responses delegation.
          #     Omitted for client delegations.
          #
          #   @param type [Symbol, :delegation]
          #     The object type, always `delegation`.

          # Where the Live model delegated the work: `client` for your application, or
          # `responses` for the configured Responses backend.
          #
          # @see OpenAI::Models::Live::DelegationCreatedEvent::Delegation#target
          module Target
            extend OpenAI::Internal::Type::Union

            variant const: -> { OpenAI::Models::Live::DelegationCreatedEvent::Delegation::Target::CLIENT }

            variant const: -> { OpenAI::Models::Live::DelegationCreatedEvent::Delegation::Target::RESPONSES }

            # @!method self.variants
            #   @return [Array(Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { OpenAI::Live::DelegationCreatedEvent::Delegation::Target::TaggedSymbol }
            end

            # @!group

            CLIENT = :client
            RESPONSES = :responses

            # @!endgroup
          end
        end
      end
    end
  end
end
