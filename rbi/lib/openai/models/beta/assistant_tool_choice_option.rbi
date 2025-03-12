# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantToolChoiceOption < OpenAI::Union
        abstract!

        class Auto < OpenAI::Enum
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

        class << self
          sig { override.returns([[NilClass, Symbol], [NilClass, OpenAI::Models::Beta::AssistantToolChoice]]) }
          private def variants
          end
        end
      end
    end
  end
end
