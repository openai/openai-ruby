# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileContentResponse < OpenAI::BaseModel
        sig { returns(T.nilable(String)) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        sig { returns(T.nilable(String)) }
        def type
        end

        sig { params(_: String).returns(String) }
        def type=(_)
        end

        sig { params(text: String, type: String).returns(T.attached_class) }
        def self.new(text: nil, type: nil)
        end

        sig { override.returns({text: String, type: String}) }
        def to_hash
        end
      end
    end
  end
end
