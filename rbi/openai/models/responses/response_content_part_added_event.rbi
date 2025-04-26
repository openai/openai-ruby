# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContentPartAddedEvent < OpenAI::Internal::Type::BaseModel
        # The index of the content part that was added.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the content part was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the content part was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The content part that was added.
        sig do
          returns(
            T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
          )
        end
        attr_accessor :part

        # The type of the event. Always `response.content_part.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a new content part is added.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            part: T.any(
              OpenAI::Models::Responses::ResponseOutputText,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Responses::ResponseOutputRefusal
            ),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that was added.
          content_index:,
          # The ID of the output item that the content part was added to.
          item_id:,
          # The index of the output item that the content part was added to.
          output_index:,
          # The content part that was added.
          part:,
          # The type of the event. Always `response.content_part.added`.
          type: :"response.content_part.added"
        ); end
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
        def to_hash; end

        # The content part that was added.
        module Part
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns([OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal])
          end
          def self.variants; end
        end
      end
    end
  end
end
