# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCallDelta < OpenAI::Internal::Type::BaseModel
            # For now, this is always going to be an empty object.
            sig { returns(T.anything) }
            attr_accessor :file_search

            # The index of the tool call in the tool calls array.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of tool call. This is always going to be `file_search` for this type of
            #   tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            # The ID of the tool call object.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            sig do
              params(
                file_search: T.anything,
                index: Integer,
                id: String,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(file_search:, index:, id: nil, type: :file_search); end

            sig { override.returns({file_search: T.anything, index: Integer, type: Symbol, id: String}) }
            def to_hash; end
          end
        end
      end
    end
  end
end
