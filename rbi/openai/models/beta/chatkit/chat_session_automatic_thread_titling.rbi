# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionAutomaticThreadTitling < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling,
                OpenAI::Internal::AnyHash
              )
            end

          # Whether automatic thread titling is enabled.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # Automatic thread title preferences for the session.
          sig { params(enabled: T::Boolean).returns(T.attached_class) }
          def self.new(
            # Whether automatic thread titling is enabled.
            enabled:
          )
          end

          sig { override.returns({ enabled: T::Boolean }) }
          def to_hash
          end
        end
      end
    end
  end
end
