# typed: strong

module OpenAI
  module Models
    class ResponseFormatJSONObject < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ResponseFormatJSONObject, OpenAI::Internal::AnyHash)
        end

      # The type of response format being defined. Always `json_object`.
      sig { returns(Symbol) }
      attr_accessor :type

      # JSON object response format. An older method of generating JSON responses. Using
      # `json_schema` is recommended for models that support it. Note that the model
      # will not generate JSON without a system or user message instructing it to do so.
      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(
        # The type of response format being defined. Always `json_object`.
        type: :json_object
      )
      end

      sig { override.returns({ type: Symbol }) }
      def to_hash
      end
    end
  end
end
