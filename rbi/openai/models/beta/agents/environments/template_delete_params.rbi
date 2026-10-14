# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Environments

          class TemplateDeleteParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::TemplateDeleteParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :environment_template_id

            sig do
              params(

                environment_template_id: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              environment_template_id:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {environment_template_id: String, request_options: OpenAI::RequestOptions}
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
