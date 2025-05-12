# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseWebSearchCallInProgressEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique ID for the output item associated with the web search call.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the web search call is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.web_search_call.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a web search call is initiated.
        sig do
          params(item_id: String, output_index: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # Unique ID for the output item associated with the web search call.
          item_id:,
          # The index of the output item that the web search call is associated with.
          output_index:,
          # The type of the event. Always `response.web_search_call.in_progress`.
          type: :"response.web_search_call.in_progress"
        )
        end

        sig do
          override.returns(
            { item_id: String, output_index: Integer, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
