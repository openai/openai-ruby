# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#retrieve
        class CertificateRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute certificate_id
          #
          #   @return [String]
          required :certificate_id, String

          # @!attribute include
          #   A list of additional fields to include in the response. Currently the only
          #   supported value is `content` to fetch the PEM content of the certificate.
          #
          #   @return [Array<Symbol, OpenAI::Models::Admin::Organization::CertificateRetrieveParams::Include>, nil]
          optional(
            :include,
            -> {
              OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Admin::Organization::CertificateRetrieveParams::Include]
            }
          )

          # @!method initialize(certificate_id:, include: nil, request_options: {})
          #   @param certificate_id [String]
          #
          #   @param include [Array<Symbol, OpenAI::Models::Admin::Organization::CertificateRetrieveParams::Include>]
          #     A list of additional fields to include in the response. Currently the only
          #     supported value is `content` to fetch the PEM content of the certificate.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          module Include
            extend OpenAI::Internal::Type::Enum

            CONTENT = :content

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
