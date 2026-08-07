# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Chat
      module ChatCompletionModality
        extend OpenAI::Internal::Type::Enum

        TEXT = :text
        AUDIO = :audio

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end
