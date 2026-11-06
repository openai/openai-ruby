# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalKeyValidateResponse < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::Admin::Organization::ExternalKeyValidateResponse,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :status

          sig do
            params(

              status: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            status:
          )
          end

          sig do
            override.returns(
              {status: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
