# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentFunctionCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentFunctionCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the function call item.
        sig { returns(String) }
        attr_accessor :id

        # The arguments to pass to the function.
        sig { returns(T.anything) }
        attr_accessor :arguments

        # The ID used to submit the function result.
        sig { returns(String) }
        attr_accessor :call_id

        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # The status of the function call.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `function_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A function call produced by the agent.
        sig do
          params(

            id: String,

            arguments: T.anything,

            call_id: String,

            name: String,

            status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the function call item.
          id:,

          # The arguments to pass to the function.
          arguments:,

          # The ID used to submit the function result.
          call_id:,

          # The name of the function to call.
          name:,

          # The status of the function call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `function_call`.

          type: :function_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              arguments: T.anything,
              call_id: String,
              name: String,
              status: OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol,
              turn_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
