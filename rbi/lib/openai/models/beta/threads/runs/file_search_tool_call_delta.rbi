# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCallDelta < OpenAI::BaseModel
            # For now, this is always going to be an empty object.
            sig { returns(T.anything) }
            def file_search
            end

            sig { params(_: T.anything).returns(T.anything) }
            def file_search=(_)
            end

            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            # The type of tool call. This is always going to be `file_search` for this type of
            #   tool call.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The ID of the tool call object.
            sig { returns(T.nilable(String)) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig do
              params(
                file_search: T.anything,
                index: Integer,
                id: String,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(file_search:, index:, id: nil, type: :file_search)
            end

            sig { override.returns({file_search: T.anything, index: Integer, type: Symbol, id: String}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
