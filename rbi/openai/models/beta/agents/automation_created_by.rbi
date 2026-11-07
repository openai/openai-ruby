# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # How the automation was created, independently of how an invocation started.
        module AutomationCreatedBy
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationCreatedBy::Developer,
              OpenAI::Beta::Agents::AutomationCreatedBy::Agent
            )
          end

          class Developer < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationCreatedBy::Developer,
                OpenAI::Internal::AnyHash
              )
            end

            # The type of the object. Always `developer`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The type of the object. Always `developer`.

              type: :developer
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationCreatedBy::Agent,
                OpenAI::Internal::AnyHash
              )
            end

            # The creator session, which is also the automation's target.
            sig { returns(String) }
            attr_accessor :session_id

            # The tool call that created the automation.
            sig { returns(String) }
            attr_accessor :tool_call_id

            # The type of the object. Always `agent`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                session_id: String,

                tool_call_id: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The creator session, which is also the automation's target.
              session_id:,

              # The tool call that created the automation.
              tool_call_id:,

              # The type of the object. Always `agent`.

              type: :agent
            )
            end

            sig do
              override.returns(
                {session_id: String, tool_call_id: String, type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Beta::Agents::AutomationCreatedBy::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
