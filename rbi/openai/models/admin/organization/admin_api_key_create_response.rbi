# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AdminAPIKeyCreateResponse < OpenAI::Models::Admin::Organization::AdminAPIKey
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::AdminAPIKeyCreateResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The value of the API key. Only shown on create.
          sig { returns(String) }
          attr_accessor :value

          # Represents an individual Admin API key in an org.
          sig { params(value: String).returns(T.attached_class) }
          def self.new(
            # The value of the API key. Only shown on create.
            value:
          )
          end

          sig { override.returns({ value: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
