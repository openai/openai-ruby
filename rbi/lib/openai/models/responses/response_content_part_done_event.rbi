# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContentPartDoneEvent < OpenAI::BaseModel
        # The index of the content part that is done.
        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        # The ID of the output item that the content part was added to.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the content part was added to.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The content part that is done.
        sig do
          returns(
            T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
          )
        end
        def part
        end

        sig do
          params(
            _: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
          )
            .returns(
              T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
            )
        end
        def part=(_)
        end

        # The type of the event. Always `response.content_part.done`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when a content part is done.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            part: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal),
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
        end
      end
    end
  end
end
