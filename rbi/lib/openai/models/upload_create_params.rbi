# typed: strong

module OpenAI
  module Models
    class UploadCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(Integer) }
      def bytes
      end

      sig { params(_: Integer).returns(Integer) }
      def bytes=(_)
      end

      sig { returns(String) }
      def filename
      end

      sig { params(_: String).returns(String) }
      def filename=(_)
      end

      sig { returns(String) }
      def mime_type
      end

      sig { params(_: String).returns(String) }
      def mime_type=(_)
      end

      sig { returns(Symbol) }
      def purpose
      end

      sig { params(_: Symbol).returns(Symbol) }
      def purpose=(_)
      end

      sig do
        params(
          bytes: Integer,
          filename: String,
          mime_type: String,
          purpose: Symbol,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(bytes:, filename:, mime_type:, purpose:, request_options: {})
      end

      sig do
        override
          .returns(
            {
              bytes: Integer,
              filename: String,
              mime_type: String,
              purpose: Symbol,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end
    end
  end
end
