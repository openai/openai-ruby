# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The index of the content part that the refusal text is added to.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The refusal text that is added.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the output item that the refusal text is added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the refusal text is added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.refusal.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a partial refusal text.
        sig do
          params(
            content_index: Integer,
            delta: String,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that the refusal text is added to.
          content_index:,
          # The refusal text that is added.
          delta:,
          # The ID of the output item that the refusal text is added to.
          item_id:,
          # The index of the output item that the refusal text is added to.
          output_index:,
          # The type of the event. Always `response.refusal.delta`.
          type: :"response.refusal.delta"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
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
