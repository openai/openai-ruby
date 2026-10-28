# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalKeyDeleteParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalKeyDeleteParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :external_key_id

          sig do
            params(

              external_key_id: String,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            external_key_id:,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {external_key_id: String, request_options: OpenAI::RequestOptions}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
