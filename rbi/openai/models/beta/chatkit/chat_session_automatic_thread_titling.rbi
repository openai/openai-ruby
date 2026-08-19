# typed: strong

module OpenAI
  module Models

    module Beta

      module ChatKit

        class ChatSessionAutomaticThreadTitling < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling,
              OpenAI::Internal::AnyHash
            )
          end

          # Whether automatic thread titling is enabled.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # Automatic thread title preferences for the session.
          sig do
            params(

              enabled: T::Boolean
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Whether automatic thread titling is enabled.

            enabled:
          )
          end

          sig do
            override.returns(
              {enabled: T::Boolean}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
