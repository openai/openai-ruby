# typed: strong

module OpenAI
  module Models
    ChatCompletionFunctionCallOption = Chat::ChatCompletionFunctionCallOption

    module Chat
      class ChatCompletionFunctionCallOption < OpenAI::Internal::Type::BaseModel
        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # Specifying a particular function via `{"name": "my_function"}` forces the model
        # to call that function.
        sig { params(name: String).returns(T.attached_class) }
        def self.new(
          # The name of the function to call.
          name:
        ); end
        sig { override.returns({name: String}) }
        def to_hash; end
      end
    end
  end
end
