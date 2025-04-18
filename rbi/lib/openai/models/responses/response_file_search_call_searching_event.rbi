# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallSearchingEvent < OpenAI::Internal::Type::BaseModel
        # The ID of the output item that the file search call is initiated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the file search call is searching.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.file_search_call.searching`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a file search is currently searching.
        sig { params(item_id: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(item_id:, output_index:, type: :"response.file_search_call.searching"); end

        sig { override.returns({item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
