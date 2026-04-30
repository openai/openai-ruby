# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class ProjectCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::ProjectCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The friendly name of the project, this name appears in reports.
          sig { returns(String) }
          attr_accessor :name

          # Create the project with the specified data residency region. Your organization
          # must have access to Data residency functionality in order to use. See
          # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          # to review the functionality and limitations of setting this field.
          sig do
            returns(
              T.nilable(
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::OrSymbol
              )
            )
          end
          attr_reader :geography

          sig do
            params(
              geography:
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::OrSymbol
            ).void
          end
          attr_writer :geography

          sig do
            params(
              name: String,
              geography:
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The friendly name of the project, this name appears in reports.
            name:,
            # Create the project with the specified data residency region. Your organization
            # must have access to Data residency functionality in order to use. See
            # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
            # to review the functionality and limitations of setting this field.
            geography: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                name: String,
                geography:
                  OpenAI::Admin::Organization::ProjectCreateParams::Geography::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Create the project with the specified data residency region. Your organization
          # must have access to Data residency functionality in order to use. See
          # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          # to review the functionality and limitations of setting this field.
          module Geography
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::ProjectCreateParams::Geography
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            US =
              T.let(
                :US,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            EU =
              T.let(
                :EU,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            JP =
              T.let(
                :JP,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            IN =
              T.let(
                :IN,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            KR =
              T.let(
                :KR,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            CA =
              T.let(
                :CA,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            AU =
              T.let(
                :AU,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )
            SG =
              T.let(
                :SG,
                OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::ProjectCreateParams::Geography::TaggedSymbol
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
