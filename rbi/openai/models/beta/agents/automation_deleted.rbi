# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class AutomationDeleted < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationDeleted,
              OpenAI::Internal::AnyHash
            )
          end

          # The deleted automation ID.
          sig { returns(String) }
          attr_accessor :id

          # Always true.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # Always `agent.automation.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          sig do
            params(

              id: String,

              deleted: T::Boolean,

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The deleted automation ID.
            id:,

            # Always true.
            deleted:,

            # Always `agent.automation.deleted`.

            object: :"agent.automation.deleted"
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
