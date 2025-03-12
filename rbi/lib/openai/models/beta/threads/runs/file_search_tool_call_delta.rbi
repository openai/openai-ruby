# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCallDelta < OpenAI::BaseModel
            sig { returns(T.anything) }
            def file_search
            end

            sig { params(_: T.anything).returns(T.anything) }
            def file_search=(_)
            end

            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

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
