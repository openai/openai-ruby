# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionRateLimitsParam < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionRateLimitsParam,
                OpenAI::Internal::AnyHash
              )
            end

          # Maximum number of requests allowed per minute for the session. Defaults to 10.
          sig { returns(T.nilable(Integer)) }
          attr_reader :max_requests_per_1_minute

          sig { params(max_requests_per_1_minute: Integer).void }
          attr_writer :max_requests_per_1_minute

          # Controls request rate limits for the session.
          sig do
            params(max_requests_per_1_minute: Integer).returns(T.attached_class)
          end
          def self.new(
            # Maximum number of requests allowed per minute for the session. Defaults to 10.
            max_requests_per_1_minute: nil
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
