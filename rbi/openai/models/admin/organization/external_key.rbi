# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalKey < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalKey,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :id

          sig { returns(T::Array[String]) }
          attr_accessor :api_project_ids

          sig { returns(Integer) }
          attr_accessor :created_at

          sig { returns(String) }
          attr_accessor :name

          sig { returns(String) }
          attr_accessor :object

          sig { returns(String) }
          attr_accessor :type

          sig { returns(String) }
          attr_accessor :workspace_id

          sig { returns(T.nilable(String)) }
          attr_reader :audience

          sig { params(audience: String).void }
          attr_writer :audience

          sig { returns(T.nilable(String)) }
          attr_reader :external_id

          sig { params(external_id: String).void }
          attr_writer :external_id

          sig { returns(T.nilable(String)) }
          attr_reader :key_name

          sig { params(key_name: String).void }
          attr_writer :key_name

          sig { returns(T.nilable(String)) }
          attr_reader :key_version

          sig { params(key_version: String).void }
          attr_writer :key_version

          sig { returns(T.nilable(String)) }
          attr_reader :kms_arn

          sig { params(kms_arn: String).void }
          attr_writer :kms_arn

          sig { returns(T.nilable(String)) }
          attr_reader :kms_key_location

          sig { params(kms_key_location: String).void }
          attr_writer :kms_key_location

          sig { returns(T.nilable(String)) }
          attr_reader :kms_key_name

          sig { params(kms_key_name: String).void }
          attr_writer :kms_key_name

          sig { returns(T.nilable(String)) }
          attr_reader :kms_key_ring_name

          sig { params(kms_key_ring_name: String).void }
          attr_writer :kms_key_ring_name

          sig { returns(T.nilable(String)) }
          attr_reader :kms_key_version

          sig { params(kms_key_version: String).void }
          attr_writer :kms_key_version

          sig { returns(T.nilable(String)) }
          attr_reader :kms_project_id

          sig { params(kms_project_id: String).void }
          attr_writer :kms_project_id

          sig { returns(T.nilable(OpenAI::Admin::Organization::ExternalKey::Purpose::TaggedSymbol)) }
          attr_reader :purpose

          sig { params(purpose: OpenAI::Admin::Organization::ExternalKey::Purpose::OrSymbol).void }
          attr_writer :purpose

          sig { returns(T.nilable(String)) }
          attr_reader :role_arn

          sig { params(role_arn: String).void }
          attr_writer :role_arn

          sig { returns(T.nilable(String)) }
          attr_reader :tenant_id

          sig { params(tenant_id: String).void }
          attr_writer :tenant_id

          sig { returns(T.nilable(String)) }
          attr_reader :vault_uri

          sig { params(vault_uri: String).void }
          attr_writer :vault_uri

          sig { returns(T.nilable(String)) }
          attr_reader :workload_identity_pool_id

          sig { params(workload_identity_pool_id: String).void }
          attr_writer :workload_identity_pool_id

          sig { returns(T.nilable(String)) }
          attr_reader :workload_identity_project_number

          sig { params(workload_identity_project_number: String).void }
          attr_writer :workload_identity_project_number

          sig { returns(T.nilable(String)) }
          attr_reader :workload_identity_provider_id

          sig { params(workload_identity_provider_id: String).void }
          attr_writer :workload_identity_provider_id

          sig do
            params(

              id: String,

              api_project_ids: T::Array[String],

              created_at: Integer,

              name: String,

              object: String,

              type: String,

              workspace_id: String,

              audience: String,

              external_id: String,

              key_name: String,

              key_version: String,

              kms_arn: String,

              kms_key_location: String,

              kms_key_name: String,

              kms_key_ring_name: String,

              kms_key_version: String,

              kms_project_id: String,

              purpose: OpenAI::Admin::Organization::ExternalKey::Purpose::OrSymbol,

              role_arn: String,

              tenant_id: String,

              vault_uri: String,

              workload_identity_pool_id: String,

              workload_identity_project_number: String,

              workload_identity_provider_id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            id:,

            api_project_ids:,

            created_at:,

            name:,

            object:,

            type:,

            workspace_id:,

            audience: nil,

            external_id: nil,

            key_name: nil,

            key_version: nil,

            kms_arn: nil,

            kms_key_location: nil,

            kms_key_name: nil,

            kms_key_ring_name: nil,

            kms_key_version: nil,

            kms_project_id: nil,

            purpose: nil,

            role_arn: nil,

            tenant_id: nil,

            vault_uri: nil,

            workload_identity_pool_id: nil,

            workload_identity_project_number: nil,

            workload_identity_provider_id: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                api_project_ids: T::Array[String],
                created_at: Integer,
                name: String,
                object: String,
                type: String,
                workspace_id: String,
                audience: String,
                external_id: String,
                key_name: String,
                key_version: String,
                kms_arn: String,
                kms_key_location: String,
                kms_key_name: String,
                kms_key_ring_name: String,
                kms_key_version: String,
                kms_project_id: String,
                purpose: OpenAI::Admin::Organization::ExternalKey::Purpose::TaggedSymbol,
                role_arn: String,
                tenant_id: String,
                vault_uri: String,
                workload_identity_pool_id: String,
                workload_identity_project_number: String,
                workload_identity_provider_id: String
              }
            )
          end
          def to_hash
          end

          module Purpose
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Admin::Organization::ExternalKey::Purpose) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            EKM = T.let(:ekm, OpenAI::Admin::Organization::ExternalKey::Purpose::TaggedSymbol)
            PSP_DECRYPTION = T.let(:psp_decryption, OpenAI::Admin::Organization::ExternalKey::Purpose::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Admin::Organization::ExternalKey::Purpose::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
