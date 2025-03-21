# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContentPartDoneEvent < OpenAI::BaseModel
        # The index of the content part that is done.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the content part was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the content part was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The content part that is done.
        sig do
          returns(
            T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
          )
        end
        attr_accessor :part

        # The type of the event. Always `response.content_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a content part is done.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            part: T.any(
              OpenAI::Models::Responses::ResponseOutputText,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Responses::ResponseOutputRefusal
            ),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content_index:, item_id:, output_index:, part:, type: :"response.content_part.done")
        end

        sig do
          override
            .returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                part: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal),
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # The content part that is done.
        module Part
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
              }
            end

          class << self
            sig do
              override
                .returns([OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal])
            end
            def variants
            end
          end
        end
      end
    end
  end
end
