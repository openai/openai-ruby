# typed: strong

module OpenAI
  module Models
    class VideoRemixParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoRemixParams, OpenAI::Internal::AnyHash)
        end

      # Updated text prompt that directs the remix generation.
      sig { returns(String) }
      attr_accessor :prompt

      sig do
        params(
          prompt: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Updated text prompt that directs the remix generation.
        prompt:,
        request_options: {}
      )
      end

      sig do
        override.returns(
          { prompt: String, request_options: OpenAI::RequestOptions }
        )
      end
      def to_hash
      end
    end
  end
end
