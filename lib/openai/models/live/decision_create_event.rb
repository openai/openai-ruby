# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #
        #   @return [Symbol, :"decision.create"]
        required :type, const: :"decision.create"

        # @!method initialize(event_id:, type: :"decision.create")
        #   Evaluate the configured questions using the current conversation and Decision
        #   inputs. Reusing an event_id is rejected for the lifetime of the session.
        #
        #   @param event_id [String]
        #   @param type [Symbol, :"decision.create"]
      end
    end
  end
end
