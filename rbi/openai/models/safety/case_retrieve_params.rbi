# typed: strong

module OpenAI
  module Models

    module Safety

      class CaseRetrieveParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Safety::CaseRetrieveParams,
            OpenAI::Internal::AnyHash
          )
        end

        # Safety case ID
        sig { returns(String) }
        attr_accessor :id

        sig do
          params(

            id: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Safety case ID
          id:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {id: String, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
