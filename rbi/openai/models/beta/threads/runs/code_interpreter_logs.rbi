# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterLogs < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterLogs,
                  OpenAI::Internal::AnyHash
                )
              end

            # The index of the output in the outputs array.
            sig { returns(Integer) }
            attr_accessor :index

            # Always `logs`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The text output from the Code Interpreter tool call.
            sig { returns(T.nilable(String)) }
            attr_reader :logs

            sig { params(logs: String).void }
            attr_writer :logs

            # Text output from the Code Interpreter tool call as part of a run step.
            sig do
              params(index: Integer, logs: String, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The index of the output in the outputs array.
              index:,
              # The text output from the Code Interpreter tool call.
              logs: nil,
              # Always `logs`.
              type: :logs
            )
            end

            sig do
              override.returns({ index: Integer, type: Symbol, logs: String })
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
