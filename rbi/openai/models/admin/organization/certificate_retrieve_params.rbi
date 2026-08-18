# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class CertificateRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::CertificateRetrieveParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :certificate_id

          # A list of additional fields to include in the response. Currently the only
          # supported value is `content` to fetch the PEM content of the certificate.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Admin::Organization::CertificateRetrieveParams::Include::OrSymbol
                ]
              )
            )
          end
          attr_reader :include

          sig do
            params(
              include:
                T::Array[
                  OpenAI::Admin::Organization::CertificateRetrieveParams::Include::OrSymbol
                ]
            ).void
          end
          attr_writer :include

          sig do
            params(
              certificate_id: String,
              include:
                T::Array[
                  OpenAI::Admin::Organization::CertificateRetrieveParams::Include::OrSymbol
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            certificate_id:,
            # A list of additional fields to include in the response. Currently the only
            # supported value is `content` to fetch the PEM content of the certificate.
            include: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                certificate_id: String,
                include:
                  T::Array[
                    OpenAI::Admin::Organization::CertificateRetrieveParams::Include::OrSymbol
                  ],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          module Include
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::CertificateRetrieveParams::Include
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CONTENT =
              T.let(
                :content,
                OpenAI::Admin::Organization::CertificateRetrieveParams::Include::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::CertificateRetrieveParams::Include::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
