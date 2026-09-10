# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class VaultCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::VaultCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          # Key-value pairs to associate with the vault, such as an application or team
          # identifier.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          # The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
          # trimming.
          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              metadata: T.nilable(T::Hash[Symbol, String]),

              name: String,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Key-value pairs to associate with the vault, such as an application or team
            # identifier.
            metadata: nil,

            # The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            # trimming.
            name: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {metadata: T.nilable(T::Hash[Symbol, String]), name: String, request_options: OpenAI::RequestOptions}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
