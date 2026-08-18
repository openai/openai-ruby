# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class GroupCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::GroupCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Human readable name for the group.
          sig { returns(String) }
          attr_accessor :name

          sig do
            params(
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Human readable name for the group.
            name:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              { name: String, request_options: OpenAI::RequestOptions }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
