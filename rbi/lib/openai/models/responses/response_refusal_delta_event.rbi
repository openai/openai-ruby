# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRefusalDeltaEvent < OpenAI::BaseModel
        # The index of the content part that the refusal text is added to.
        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        # The refusal text that is added.
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
        end

        # The ID of the output item that the refusal text is added to.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the refusal text is added to.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.refusal.delta`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when there is a partial refusal text.
        sig do
          params(content_index: Integer, delta: String, item_id: String, output_index: Integer, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(content_index:, delta:, item_id:, output_index:, type: :"response.refusal.delta")
        end

        sig do
          override
            .returns({
                       content_index: Integer,
                       delta: String,
                       item_id: String,
                       output_index: Integer,
                       type: Symbol
                     })
        end
        def to_hash
        end
      end
    end
  end
end
