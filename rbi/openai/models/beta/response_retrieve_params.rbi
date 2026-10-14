# typed: strong

module OpenAI
  module Models
    module Beta
      class ResponseRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::ResponseRetrieveParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :response_id

        # Additional fields to include in the response. See the `include` parameter for
        # Response creation above for more information.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol]
          ).void
        end
        attr_writer :include

        # When true, stream obfuscation will be enabled. Stream obfuscation adds random
        # characters to an `obfuscation` field on streaming delta events to normalize
        # payload sizes as a mitigation to certain side-channel attacks. These obfuscation
        # fields are included by default, but add a small amount of overhead to the data
        # stream. You can set `include_obfuscation` to false to optimize for bandwidth if
        # you trust the network links between your application and the OpenAI API.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :include_obfuscation

        sig { params(include_obfuscation: T::Boolean).void }
        attr_writer :include_obfuscation

        # The sequence number of the event after which to start streaming.
        sig { returns(T.nilable(Integer)) }
        attr_reader :starting_after

        sig { params(starting_after: Integer).void }
        attr_writer :starting_after

        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Beta::ResponseRetrieveParams::Beta::OrSymbol]
            )
          )
        end
        attr_reader :betas

        sig do
          params(
            betas:
              T::Array[OpenAI::Beta::ResponseRetrieveParams::Beta::OrSymbol]
          ).void
        end
        attr_writer :betas

        sig do
          params(
            response_id: String,
            include: T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol],
            include_obfuscation: T::Boolean,
            starting_after: Integer,
            betas:
              T::Array[OpenAI::Beta::ResponseRetrieveParams::Beta::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          response_id:,
          # Additional fields to include in the response. See the `include` parameter for
          # Response creation above for more information.
          include: nil,
          # When true, stream obfuscation will be enabled. Stream obfuscation adds random
          # characters to an `obfuscation` field on streaming delta events to normalize
          # payload sizes as a mitigation to certain side-channel attacks. These obfuscation
          # fields are included by default, but add a small amount of overhead to the data
          # stream. You can set `include_obfuscation` to false to optimize for bandwidth if
          # you trust the network links between your application and the OpenAI API.
          include_obfuscation: nil,
          # The sequence number of the event after which to start streaming.
          starting_after: nil,
          betas: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              response_id: String,
              include: T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol],
              include_obfuscation: T::Boolean,
              starting_after: Integer,
              betas:
                T::Array[OpenAI::Beta::ResponseRetrieveParams::Beta::OrSymbol],
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
              T.all(Symbol, OpenAI::Beta::ResponseRetrieveParams::Beta)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          RESPONSES_MULTI_AGENT_V1 =
            T.let(
              :"responses_multi_agent=v1",
              OpenAI::Beta::ResponseRetrieveParams::Beta::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseRetrieveParams::Beta::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
