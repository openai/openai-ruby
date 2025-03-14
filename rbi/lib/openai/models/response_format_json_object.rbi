# typed: strong

module OpenAI
  module Models
    class ResponseFormatJSONObject < OpenAI::BaseModel
      # The type of response format being defined. Always `json_object`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      # JSON object response format. An older method of generating JSON responses. Using
      #   `json_schema` is recommended for models that support it. Note that the model
      #   will not generate JSON without a system or user message instructing it to do so.
      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(type: :json_object)
      end

      sig { override.returns({type: Symbol}) }
      def to_hash
      end
    end
  end
end
