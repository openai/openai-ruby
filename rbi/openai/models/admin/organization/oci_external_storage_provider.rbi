# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class OciExternalStorageProvider < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::OciExternalStorageProvider,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :bucket

          sig { returns(String) }
          attr_accessor :region

          sig { returns(String) }
          attr_accessor :tenancy_ocid

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              bucket: String,

              region: String,

              tenancy_ocid: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            bucket:,

            region:,

            tenancy_ocid:,

            type: :oci
          )
          end

          sig do
            override.returns(
              {bucket: String, region: String, tenancy_ocid: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
