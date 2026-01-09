# typed: strong

module OpenAI
  module Models
    class VideoCreateError < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoCreateError, OpenAI::Internal::AnyHash)
        end

      # A machine-readable error code that was returned.
      sig { returns(String) }
      attr_accessor :code

      # A human-readable description of the error that was returned.
      sig { returns(String) }
      attr_accessor :message

      # An error that occurred while generating the response.
      sig { params(code: String, message: String).returns(T.attached_class) }
      def self.new(
        # A machine-readable error code that was returned.
        code:,
        # A human-readable description of the error that was returned.
        message:
      )
      end

      sig { override.returns({ code: String, message: String }) }
      def to_hash
      end
    end
  end
end
