# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionExpiresAfterParam < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionExpiresAfterParam,
                OpenAI::Internal::AnyHash
              )
            end

          # Base timestamp used to calculate expiration. Currently fixed to `created_at`.
          sig { returns(Symbol) }
          attr_accessor :anchor

          # Number of seconds after the anchor when the session expires.
          sig { returns(Integer) }
          attr_accessor :seconds

          # Controls when the session expires relative to an anchor timestamp.
          sig do
            params(seconds: Integer, anchor: Symbol).returns(T.attached_class)
          end
          def self.new(
            # Number of seconds after the anchor when the session expires.
            seconds:,
            # Base timestamp used to calculate expiration. Currently fixed to `created_at`.
            anchor: :created_at
          )
          end

          sig { override.returns({ anchor: Symbol, seconds: Integer }) }
          def to_hash
          end
        end
      end
    end
  end
end
