# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalStorageConfiguration < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalStorageConfiguration,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :id

          sig { returns(Integer) }
          attr_accessor :created_at

          sig { returns(String) }
          attr_accessor :geography

          sig { returns(Symbol) }
          attr_accessor :object

          sig { returns(String) }
          attr_accessor :project_id

          sig { returns(OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider::Variants) }
          attr_accessor :provider

          sig { returns(OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::TaggedSymbol) }
          attr_accessor :status

          sig do
            params(

              id: String,

              created_at: Integer,

              geography: String,

              project_id: String,

              provider: T.any(
                OpenAI::Admin::Organization::AwsExternalStorageProvider::OrHash,
                OpenAI::Admin::Organization::AzureExternalStorageProvider::OrHash
              ),

              status: OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::OrSymbol,

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            id:,

            created_at:,

            geography:,

            project_id:,

            provider:,

            status:,

            object: :"organization.external_storage"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                geography: String,
                object: Symbol,
                project_id: String,
                provider: OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider::Variants,
                status: OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          module Provider
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Admin::Organization::AwsExternalStorageProvider,
                OpenAI::Admin::Organization::AzureExternalStorageProvider
              )
            }

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider::Variants])
            }
            def self.variants
            end

          end

          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Admin::Organization::ExternalStorageConfiguration::Status)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PENDING = T.let(:pending, OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::TaggedSymbol)
            VALIDATED = T.let(
              :validated,
              OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::TaggedSymbol
            )
            UNHEALTHY = T.let(
              :unhealthy,
              OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::TaggedSymbol
            )

            sig {
              override.returns(
                T::Array[OpenAI::Admin::Organization::ExternalStorageConfiguration::Status::TaggedSymbol]
              )
            }
            def self.values
            end
          end

        end

      end

    end

  end
end
