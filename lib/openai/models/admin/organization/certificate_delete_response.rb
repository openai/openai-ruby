# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#delete
        class CertificateDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the certificate that was deleted.
          #
          #   @return [String]
          required :id, String

          # @!attribute object
          #   The object type, must be `certificate.deleted`.
          #
          #   @return [Symbol, :"certificate.deleted"]
          required :object, const: :"certificate.deleted"

          # @!method initialize(id:, object: :"certificate.deleted")
          #   @param id [String] The ID of the certificate that was deleted.
          #
          #   @param object [Symbol, :"certificate.deleted"] The object type, must be `certificate.deleted`.
        end
      end
    end
  end
end
