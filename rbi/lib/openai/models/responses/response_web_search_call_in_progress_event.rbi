# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallInProgressEvent < OpenAI::BaseModel
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

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(item_id: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(item_id:, output_index:, type: :"response.web_search_call.in_progress")
        end

        sig { override.returns({item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
