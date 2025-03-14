# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallSearchingEvent < OpenAI::BaseModel
        # The ID of the output item that the file search call is initiated.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the file search call is searching.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.file_search_call.searching`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when a file search is currently searching.
        sig { params(item_id: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(item_id:, output_index:, type: :"response.file_search_call.searching")
        end

        sig { override.returns({item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
