# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceOptions < OpenAI::Enum
        abstract!

        NONE = :none
        AUTO = :auto
        REQUIRED = :required

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
