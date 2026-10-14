# typed: strong

module OpenAI
  module Helpers
    module Beta
      module Agents
        module ModelAdapter
          sig { params(model: T.untyped, parameter: String).void }
          def self.validate!(model, parameter:)
          end

          sig do
            params(model: T.class_of(OpenAI::BaseModel), value: T.untyped, memoize: T::Boolean)
              .returns(T.nilable(OpenAI::BaseModel))
          end
          def self.coerce(model, value, memoize: false)
          end
        end
      end
    end
  end
end
