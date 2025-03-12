# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRefusalDoneEvent < OpenAI::BaseModel
        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        sig { returns(String) }
        def refusal
        end

        sig { params(_: String).returns(String) }
        def refusal=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            refusal: String,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content_index:, item_id:, output_index:, refusal:, type: :"response.refusal.done")
        end

        sig do
          override
            .returns({
                       content_index: Integer,
                       item_id: String,
                       output_index: Integer,
                       refusal: String,
                       type: Symbol
                     })
        end
        def to_hash
        end
      end
    end
  end
end
