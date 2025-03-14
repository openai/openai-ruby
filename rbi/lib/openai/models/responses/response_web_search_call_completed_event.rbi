# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallCompletedEvent < OpenAI::BaseModel
        # Unique ID for the output item associated with the web search call.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the web search call is associated with.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.web_search_call.completed`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when a web search call is completed.
        sig { params(item_id: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(item_id:, output_index:, type: :"response.web_search_call.completed")
        end

        sig { override.returns({item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
