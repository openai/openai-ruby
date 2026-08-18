# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class CertificateDeleteResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::CertificateDeleteResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of the certificate that was deleted.
          sig { returns(String) }
          attr_accessor :id

          # The object type, must be `certificate.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          sig { params(id: String, object: Symbol).returns(T.attached_class) }
          def self.new(
            # The ID of the certificate that was deleted.
            id:,
            # The object type, must be `certificate.deleted`.
            object: :"certificate.deleted"
          )
          end

          sig { override.returns({ id: String, object: Symbol }) }
          def to_hash
          end
        end
      end
    end
  end
end
