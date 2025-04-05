# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionFunctionCallOption < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!parse
        #   # Specifying a particular function via `{"name": "my_function"}` forces the model
        #   # to call that function.
        #   #
        #   # @param name [String]
        #   #
        #   def initialize(name:, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ChatCompletionFunctionCallOption = Chat::ChatCompletionFunctionCallOption
  end
end
