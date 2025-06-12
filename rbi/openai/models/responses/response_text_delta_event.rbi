# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseTextDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part that the text delta was added to.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The text delta that was added.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the output item that the text delta was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the text delta was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.output_text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is an additional text delta.
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
          # The index of the content part that the text delta was added to.
          content_index:,
          # The text delta that was added.
          delta:,
          # The ID of the output item that the text delta was added to.
          item_id:,
          # The index of the output item that the text delta was added to.
          output_index:,
          # The type of the event. Always `response.output_text.delta`.
          type: :"response.output_text.delta"
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
