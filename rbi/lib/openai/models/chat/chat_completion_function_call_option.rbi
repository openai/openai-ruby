# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionFunctionCallOption < OpenAI::BaseModel
        # The name of the function to call.
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # Specifying a particular function via `{"name": "my_function"}` forces the model
        #   to call that function.
        sig { params(name: String).returns(T.attached_class) }
        def self.new(name:)
        end

        sig { override.returns({name: String}) }
        def to_hash
        end
      end
    end

    ChatCompletionFunctionCallOption = Chat::ChatCompletionFunctionCallOption
  end
end
