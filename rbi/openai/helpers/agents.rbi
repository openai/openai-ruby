# typed: strong

module OpenAI
  module Helpers
    module Agents
      ToolOutput = T.type_alias {
        T.nilable(
          T.any(
            String,
            OpenAI::Internal::AnyHash,
            T::Array[T.any(OpenAI::Models::Beta::InputContentParam::Variants, OpenAI::Internal::AnyHash)]
          )
        )
      }
      ToolHandler = T.type_alias { T.proc.params(arguments: T::Hash[String, T.untyped]).returns(ToolOutput) }

      class SessionStream
        include Enumerable
        Elem = type_member { {fixed: OpenAI::Models::Beta::AgentSessionEvent::Variants} }

        sig {
          params(block: T.nilable(T.proc.params(event: OpenAI::Models::Beta::AgentSessionEvent::Variants).void)).returns(
            T.any(T.self_type, T::Enumerator[OpenAI::Models::Beta::AgentSessionEvent::Variants])
          )
        }
        def each(&block)
        end

        sig { void }
        def close
        end

        sig { returns(T.self_type) }
        def until_done
        end
      end
    end
  end

  module Resources
    class Beta
      class Agents
        class Sessions
          sig do
            params(
              session_id: String,
              input: T.any(String, T::Array[OpenAI::Models::Beta::AgentSessionInputMessageParam::OrHash]),
              tool_handlers: T::Hash[String, OpenAI::Helpers::Agents::ToolHandler],
              idempotency_key: T.nilable(String),
              request_options: T.nilable(OpenAI::RequestOptions::OrHash),
              block: T.nilable(T.proc.params(stream: OpenAI::Helpers::Agents::SessionStream).void)
            )
              .returns(OpenAI::Helpers::Agents::SessionStream)
          end
          def stream(session_id, input:, tool_handlers: {}, idempotency_key: nil, request_options: {}, &block)
          end
        end
      end
    end
  end

  module Models
    module Beta
      class AgentSessionMessage < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def output_text
        end
      end
    end
  end
end
