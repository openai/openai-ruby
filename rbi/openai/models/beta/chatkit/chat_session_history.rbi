# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionHistory < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionHistory,
                OpenAI::Internal::AnyHash
              )
            end

          # Indicates if chat history is persisted for the session.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # Number of prior threads surfaced in history views. Defaults to null when all
          # history is retained.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :recent_threads

          # History retention preferences returned for the session.
          sig do
            params(
              enabled: T::Boolean,
              recent_threads: T.nilable(Integer)
            ).returns(T.attached_class)
          end
          def self.new(
            # Indicates if chat history is persisted for the session.
            enabled:,
            # Number of prior threads surfaced in history views. Defaults to null when all
            # history is retained.
            recent_threads:
          )
          end

          sig do
            override.returns(
              { enabled: T::Boolean, recent_threads: T.nilable(Integer) }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
