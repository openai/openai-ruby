# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class SessionUpdateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::SessionUpdateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :session_id

          # Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          # characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          sig do
            params(

              session_id: String,

              metadata: T.nilable(T::Hash[Symbol, String]),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            session_id:,

            # Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
            # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            # characters.
            metadata: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                session_id: String,
                metadata: T.nilable(T::Hash[Symbol, String]),
                request_options: OpenAI::RequestOptions
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
