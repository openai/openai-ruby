# typed: strong

module OpenAI
  module Helpers
    module Beta
      module Agents
        class TurnResult
          sig { returns(OpenAI::Models::Beta::Agents::Sessions::Turn) }
          def turn
          end

          sig { returns(T::Array[OpenAI::Models::Beta::AgentSessionMessage]) }
          def messages
          end

          sig { returns(String) }
          def session_id
          end

          sig { returns(String) }
          def turn_id
          end

          sig { returns(String) }
          def output_text
          end

          sig { returns(T.untyped) }
          def output_parsed
          end

          sig {
            params(output_type: T.class_of(OpenAI::Helpers::StructuredOutput::BaseModel)).returns(ParsedTurnResult)
          }
          def parse(output_type:)
          end
        end

        class ResultError < OpenAI::Errors::Error
          sig { returns(Symbol) }
          def reason
          end

          sig { returns(T.nilable(String)) }
          def session_id
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Agents::Sessions::Turn)) }
          def turn
          end

          sig { returns(T::Array[OpenAI::Models::Beta::AgentSessionMessage]) }
          def messages
          end

          sig {
            returns(
              T::Array[T.any(OpenAI::Models::Beta::AgentSession::RequiredAction::Variants, OpenAI::Internal::AnyHash)]
            )
          }
          def required_actions
          end

          sig { returns(T.nilable(String)) }
          def turn_id
          end
        end

        # @api private
        class ResultCollector
          sig { params(session_id: T.nilable(String), handler_names: T::Array[String]).void }
          def initialize(session_id: nil, handler_names: [])
          end

          sig { void }
          def enable
          end

          sig {
            params(event: T.any(OpenAI::Models::Beta::AgentSessionEvent::Variants, OpenAI::Internal::AnyHash)).void
          }
          def observe(event)
          end

          sig { returns(T.nilable(T::Boolean)) }
          def stopped?
          end

          sig { params(error: StandardError).void }
          def observe_error(error)
          end

          sig { returns(TurnResult) }
          def result
          end
        end

        class ParsedTurnResult < TurnResult
          sig { returns(TurnResult) }
          attr_reader :raw_result

          sig { returns(T.untyped) }
          attr_reader :output_parsed
        end

        class OutputParseError < OpenAI::Errors::Error
          sig { returns(TurnResult) }
          attr_reader :raw_result
        end

        # @api private
        class OutputParser
          sig { params(model: T.class_of(OpenAI::Helpers::StructuredOutput::BaseModel)).void }
          def initialize(model)
          end

          sig { params(params: OpenAI::Internal::AnyHash).void }
          def prepare_request(params)
          end

          sig { params(result: TurnResult).returns(ParsedTurnResult) }
          def parse(result)
          end
        end

        class CreationStream < OpenAI::Internal::Stream
          Message = type_member(:in) { {fixed: OpenAI::Internal::Util::ServerSentEvent} }
          Elem = type_member(:out) { {fixed: OpenAI::Models::Beta::AgentSessionEvent::Variants} }

          sig { returns(TurnResult) }
          def get_final_result
          end

          sig { returns(T.self_type) }
          def with_result_collection
          end

          # @api private
          sig { params(parser: T.nilable(OutputParser)).returns(T.self_type) }
          def configure_output_parser(parser)
          end

          # @api private
          sig do
            params(
              sessions: OpenAI::Resources::Beta::Agents::Sessions,
              tool_handlers: T::Hash[String, OpenAI::Helpers::Agents::ToolHandler],
              request_options: T.untyped
            )
              .returns(T.self_type)
          end
          def configure_tool_handlers(sessions:, tool_handlers:, request_options:)
          end
        end
      end
    end
  end
end
