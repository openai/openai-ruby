# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Sessions

          class EventStreamParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::EventStreamParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :session_id

            # Whether to include obfuscation padding in events on this connection. Defaults to
            # `true`.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :include_obfuscation

            sig { params(include_obfuscation: T::Boolean).void }
            attr_writer :include_obfuscation

            sig do
              params(

                session_id: String,

                include_obfuscation: T::Boolean,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              session_id:,

              # Whether to include obfuscation padding in events on this connection. Defaults to
              # `true`.
              include_obfuscation: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {session_id: String, include_obfuscation: T::Boolean, request_options: OpenAI::RequestOptions}
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
