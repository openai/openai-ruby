# typed: strong

module OpenAI
  module Models
    class Image < OpenAI::BaseModel
      sig { returns(T.nilable(String)) }
      def b64_json
      end

      sig { params(_: String).returns(String) }
      def b64_json=(_)
      end

      sig { returns(T.nilable(String)) }
      def revised_prompt
      end

      sig { params(_: String).returns(String) }
      def revised_prompt=(_)
      end

      sig { returns(T.nilable(String)) }
      def url
      end

      sig { params(_: String).returns(String) }
      def url=(_)
      end

      sig { params(b64_json: String, revised_prompt: String, url: String).returns(T.attached_class) }
      def self.new(b64_json: nil, revised_prompt: nil, url: nil)
      end

      sig { override.returns({b64_json: String, revised_prompt: String, url: String}) }
      def to_hash
      end
    end
  end
end
