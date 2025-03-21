# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallCompletedEvent < OpenAI::BaseModel
        # Unique ID for the output item associated with the web search call.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the web search call is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.web_search_call.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

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
