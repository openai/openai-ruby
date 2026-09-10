# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Input submitted to an existing session.
      module AgentSessionInputParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Adds one or more user messages and starts a turn.
        variant(
          :"agent.session.input.message",
          -> { OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage }
        )

        # Cancels the session's active turn.
        variant(
          :"agent.session.input.cancel",
          -> { OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel }
        )

        # Submits the result of a function call.
        variant(
          :"agent.session.input.tool_result",
          -> { OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult }
        )

        class AgentSessionInputMessage < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #   The user messages to add to the session.
          #
          #   @return [Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>]
          required :input, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::AgentSessionInputMessageParam] }

          # @!attribute type
          #   The type of the object. Always `agent.session.input.message`.
          #
          #   @return [Symbol, :"agent.session.input.message"]
          required :type, const: :"agent.session.input.message"

          # @!method initialize(input:, type: :"agent.session.input.message")
          #   Adds one or more user messages and starts a turn.
          #
          #   @param input [Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>]
          #     The user messages to add to the session.
          #
          #   @param type [Symbol, :"agent.session.input.message"]
          #     The type of the object. Always `agent.session.input.message`.
        end

        class AgentSessionInputCancel < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `agent.session.input.cancel`.
          #
          #   @return [Symbol, :"agent.session.input.cancel"]
          required :type, const: :"agent.session.input.cancel"

          # @!method initialize(type: :"agent.session.input.cancel")
          #   Cancels the session's active turn.
          #
          #   @param type [Symbol, :"agent.session.input.cancel"]
          #     The type of the object. Always `agent.session.input.cancel`.
        end

        class AgentSessionInputToolResult < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #   The ID of the function call.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute success
          #   Whether the function call succeeded.
          #
          #   @return [Boolean]
          required :success, OpenAI::Internal::Type::Boolean

          # @!attribute turn_id
          #   The ID of the turn that requested the function call.
          #
          #   @return [String]
          required :turn_id, String

          # @!attribute type
          #   The type of the object. Always `agent.session.input.tool_result`.
          #
          #   @return [Symbol, :"agent.session.input.tool_result"]
          required :type, const: :"agent.session.input.tool_result"

          # @!attribute error
          #   The error message when the call failed.
          #
          #   @return [String, nil]
          optional :error, String, nil?: true

          # @!attribute output
          #   A function result represented as text or supported model-input content.
          #
          #   @return [String, Array<OpenAI::Models::Beta::InputContentParam::InputText, OpenAI::Models::Beta::InputContentParam::InputImage>, nil]
          optional :output, union: -> { OpenAI::Beta::AgentFunctionCallOutputParam }, nil?: true

          # @!method initialize(call_id:, success:, turn_id:, error: nil, output: nil, type: :"agent.session.input.tool_result")
          #   Submits the result of a function call.
          #
          #   @param call_id [String]
          #     The ID of the function call.
          #
          #   @param success [Boolean]
          #     Whether the function call succeeded.
          #
          #   @param turn_id [String]
          #     The ID of the turn that requested the function call.
          #
          #   @param error [String, nil]
          #     The error message when the call failed.
          #
          #   @param output [String, Array<OpenAI::Models::Beta::InputContentParam::InputText, OpenAI::Models::Beta::InputContentParam::InputImage>, nil]
          #     A function result represented as text or supported model-input content.
          #
          #   @param type [Symbol, :"agent.session.input.tool_result"]
          #     The type of the object. Always `agent.session.input.tool_result`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputMessage, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputCancel, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputToolResult)]
      end
    end
  end
end
