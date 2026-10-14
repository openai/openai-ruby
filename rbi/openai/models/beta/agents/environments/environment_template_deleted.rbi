# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        EnvironmentTemplateDeleted = Environments::EnvironmentTemplateDeleted

        module Environments

          class EnvironmentTemplateDeleted < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::EnvironmentTemplateDeleted,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the deleted environment template.
            sig { returns(String) }
            attr_accessor :id

            # Whether the environment template was deleted. Always `true`.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # The object type. Always `agent.environment.template.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # A deleted reusable environment template.
            sig do
              params(

                id: String,

                deleted: T::Boolean,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the deleted environment template.
              id:,

              # Whether the environment template was deleted. Always `true`.
              deleted:,

              # The object type. Always `agent.environment.template.deleted`.

              object: :"agent.environment.template.deleted"
            )
            end

            sig do
              override.returns(
                {id: String, deleted: T::Boolean, object: Symbol}
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
