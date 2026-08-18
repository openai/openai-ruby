# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallSearchingEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseFileSearchCallSearchingEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the output item that the file search call is initiated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the file search call is searching.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.file_search_call.searching`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a file search is currently searching.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the output item that the file search call is initiated.
          item_id:,
          # The index of the output item that the file search call is searching.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.file_search_call.searching`.
          type: :"response.file_search_call.searching"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
