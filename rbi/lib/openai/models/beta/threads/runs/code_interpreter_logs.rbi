# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterLogs < OpenAI::BaseModel
            # The index of the output in the outputs array.
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            # Always `logs`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The text output from the Code Interpreter tool call.
            sig { returns(T.nilable(String)) }
            def logs
            end

            sig { params(_: String).returns(String) }
            def logs=(_)
            end

            # Text output from the Code Interpreter tool call as part of a run step.
            sig { params(index: Integer, logs: String, type: Symbol).returns(T.attached_class) }
            def self.new(index:, logs: nil, type: :logs)
            end

            sig { override.returns({index: Integer, type: Symbol, logs: String}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
