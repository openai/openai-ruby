# typed: strong

module OpenAI
  module Models
    module Beta
      class ResponseDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::ResponseDeleteParams, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :response_id

        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Beta::ResponseDeleteParams::Beta::OrSymbol]
            )
          )
        end
        attr_reader :betas

        sig do
          params(
            betas: T::Array[OpenAI::Beta::ResponseDeleteParams::Beta::OrSymbol]
          ).void
        end
        attr_writer :betas

        sig do
          params(
            response_id: String,
            betas: T::Array[OpenAI::Beta::ResponseDeleteParams::Beta::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(response_id:, betas: nil, request_options: {})
        end

        sig do
          override.returns(
            {
              response_id: String,
              betas:
                T::Array[OpenAI::Beta::ResponseDeleteParams::Beta::OrSymbol],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        module Beta
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseDeleteParams::Beta)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          RESPONSES_MULTI_AGENT_V1 =
            T.let(
              :"responses_multi_agent=v1",
              OpenAI::Beta::ResponseDeleteParams::Beta::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseDeleteParams::Beta::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
