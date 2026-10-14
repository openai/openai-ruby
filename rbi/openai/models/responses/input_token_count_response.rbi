# typed: strong

module OpenAI
  module Models
    module Responses
      class InputTokenCountResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::Responses::InputTokenCountResponse,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(Integer) }
        attr_accessor :input_tokens

        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(input_tokens: Integer, object: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(input_tokens:, object: :"response.input_tokens")
        end

        sig { override.returns({ input_tokens: Integer, object: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
