# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class GroupUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::GroupUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :group_id

          # New display name for the group.
          sig { returns(String) }
          attr_accessor :name

          sig do
            params(
              group_id: String,
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            group_id:,
            # New display name for the group.
            name:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                group_id: String,
                name: String,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
