# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionNamedToolChoice < OpenAI::Internal::Type::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function) }
        attr_reader :function

        sig do
          params(
            function: T.any(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        # Specifies a tool the model should use. Use to force the model to call a specific
        #   function.
        sig do
          params(
            function: T.any(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, OpenAI::Internal::AnyHash),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(function:, type: :function); end

        sig { override.returns({function: OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, type: Symbol}) }
        def to_hash; end

        class Function < OpenAI::Internal::Type::BaseModel
          # The name of the function to call.
          sig { returns(String) }
          attr_accessor :name

          sig { params(name: String).returns(T.attached_class) }
          def self.new(name:); end

          sig { override.returns({name: String}) }
          def to_hash; end
        end
      end
    end

    ChatCompletionNamedToolChoice = Chat::ChatCompletionNamedToolChoice
  end
end
