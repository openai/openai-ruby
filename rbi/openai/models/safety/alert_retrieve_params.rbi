# typed: strong

module OpenAI
  module Models

    module Safety

      class AlertRetrieveParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Safety::AlertRetrieveParams,
            OpenAI::Internal::AnyHash
          )
        end

        # Project safety alert ID
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

          # Project safety alert ID
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
