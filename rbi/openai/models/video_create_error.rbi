# typed: strong

module OpenAI
  module Models
    class VideoCreateError < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoCreateError, OpenAI::Internal::AnyHash)
        end

      sig { returns(String) }
      attr_accessor :code

      sig { returns(String) }
      attr_accessor :message

      sig { params(code: String, message: String).returns(T.attached_class) }
      def self.new(code:, message:)
      end

      sig { override.returns({ code: String, message: String }) }
      def to_hash
      end
    end
  end
end
