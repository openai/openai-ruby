# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionRateLimits < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionRateLimits,
                OpenAI::Internal::AnyHash
              )
            end

          # Maximum allowed requests per one-minute window.
          sig { returns(Integer) }
          attr_accessor :max_requests_per_1_minute

          # Active per-minute request limit for the session.
          sig do
            params(max_requests_per_1_minute: Integer).returns(T.attached_class)
          end
          def self.new(
            # Maximum allowed requests per one-minute window.
            max_requests_per_1_minute:
          )
          end

          sig { override.returns({ max_requests_per_1_minute: Integer }) }
          def to_hash
          end
        end
      end
    end
  end
end
