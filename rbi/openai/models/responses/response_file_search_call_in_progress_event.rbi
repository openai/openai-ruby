# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        # The ID of the output item that the file search call is initiated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the file search call is initiated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.file_search_call.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a file search call is initiated.
        sig { params(item_id: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The ID of the output item that the file search call is initiated.
          item_id:,
          # The index of the output item that the file search call is initiated.
          output_index:,
          # The type of the event. Always `response.file_search_call.in_progress`.
          type: :"response.file_search_call.in_progress"
        ); end
        sig { override.returns({item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
