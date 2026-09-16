# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseCompactionCompactingEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseCompactionCompactingEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the compaction output item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the compaction output item.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.compaction.compacting`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when new summary content is sampled for a compaction trigger. Contains
        # no summary content.
        sig do
          params(

            item_id: String,

            output_index: Integer,

            sequence_number: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the compaction output item.
          item_id:,

          # The index of the compaction output item.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # The type of the event, always `response.compaction.compacting`.

          type: :"response.compaction.compacting"
        )
        end

        sig do
          override.returns(
            {item_id: String, output_index: Integer, sequence_number: Integer, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
