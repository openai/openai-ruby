# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class TruncationObject < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The truncation strategy to use for the thread. The default is `auto`. If set to
        #   `last_messages`, the thread will be truncated to the n most recent messages in
        #   the thread. When set to `auto`, messages in the middle of the thread will be
        #   dropped to fit the context length of the model, `max_prompt_tokens`.
        #
        #   @return [Symbol, OpenAI::Beta::TruncationObject::Type]
        required :type, enum: -> { OpenAI::Beta::TruncationObject::Type }

        # @!attribute last_messages
        #   The number of most recent messages from the thread when constructing the context
        #   for the run.
        #
        #   @return [Integer, nil]
        optional :last_messages, Integer, nil?: true

        # @!method initialize(type:, last_messages: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Beta::TruncationObject} for more details.
        #
        #   Controls for how a thread will be truncated prior to the run. Use this to
        #   control the intial context window of the run.
        #
        #   @param type [Symbol, OpenAI::Beta::TruncationObject::Type] The truncation strategy to use for the thread. The default is `auto`. If set to
        #
        #   @param last_messages [Integer, nil] The number of most recent messages from the thread when constructing the context

        # The truncation strategy to use for the thread. The default is `auto`. If set to
        # `last_messages`, the thread will be truncated to the n most recent messages in
        # the thread. When set to `auto`, messages in the middle of the thread will be
        # dropped to fit the context length of the model, `max_prompt_tokens`.
        #
        # @see OpenAI::Beta::TruncationObject#type
        module Type
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          LAST_MESSAGES = :last_messages

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
