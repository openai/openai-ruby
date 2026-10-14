# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class GcpExternalStorageProvider < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::GcpExternalStorageProvider,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :audience

          sig { returns(String) }
          attr_accessor :bucket

          sig { returns(String) }
          attr_accessor :region

          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(String) }
          attr_accessor :workload_identity_pool_id

          sig { returns(String) }
          attr_accessor :workload_identity_project_number

          sig { returns(String) }
          attr_accessor :workload_identity_provider_id

          sig do
            params(

              audience: String,

              bucket: String,

              region: String,

              workload_identity_pool_id: String,

              workload_identity_project_number: String,

              workload_identity_provider_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            audience:,

            bucket:,

            region:,

            workload_identity_pool_id:,

            workload_identity_project_number:,

            workload_identity_provider_id:,

            type: :gcp
          )
          end

          sig do
            override.returns(
              {
                audience: String,
                bucket: String,
                region: String,
                type: Symbol,
                workload_identity_pool_id: String,
                workload_identity_project_number: String,
                workload_identity_provider_id: String
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
