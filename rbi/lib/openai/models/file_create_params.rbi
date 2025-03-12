# typed: strong

module OpenAI
  module Models
    class FileCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(T.any(IO, StringIO)) }
      def file
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def file=(_)
      end

      sig { returns(Symbol) }
      def purpose
      end

      sig { params(_: Symbol).returns(Symbol) }
      def purpose=(_)
      end

      sig do
        params(
          file: T.any(IO, StringIO),
          purpose: Symbol,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(file:, purpose:, request_options: {})
      end

      sig do
        override.returns(
          {
            file: T.any(IO, StringIO),
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
