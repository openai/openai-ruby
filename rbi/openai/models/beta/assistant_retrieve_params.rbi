# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::AssistantRetrieveParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig do
          params(request_options: OpenAI::RequestOptions::OrHash).returns(
            T.attached_class
          )
        end
        def self.new(request_options: {})
        end

        sig { override.returns({ request_options: OpenAI::RequestOptions }) }
        def to_hash
        end
      end
    end
  end
end
