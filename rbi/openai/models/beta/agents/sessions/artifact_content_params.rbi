# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Sessions

          class ArtifactContentParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::ArtifactContentParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :session_id

            sig { returns(String) }
            attr_accessor :artifact_id

            sig do
              params(

                session_id: String,

                artifact_id: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              session_id:,

              artifact_id:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {session_id: String, artifact_id: String, request_options: OpenAI::RequestOptions}
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
