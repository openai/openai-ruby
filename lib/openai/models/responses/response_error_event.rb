# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseErrorEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The error code.
        #
        #   @return [String, nil]
        required :code, String, nil?: true

        # @!attribute message
        #   The error message.
        #
        #   @return [String]
        required :message, String

        # @!attribute param
        #   The error parameter.
        #
        #   @return [String, nil]
        required :param, String, nil?: true

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `error`.
        #
        #   @return [Symbol, :error]
        required :type, const: :error

        # @!method initialize(code:, message:, param:, sequence_number:, type: :error)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseErrorEvent} for more details.
        #
        #   Emitted when an error occurs.
        #
        #   @param code [String, nil] The error code.
        #
        #   @param message [String] The error message.
        #
        #   @param param [String, nil] The error parameter.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :error] The type of the event. Always `error`.
      end
    end
  end
end
