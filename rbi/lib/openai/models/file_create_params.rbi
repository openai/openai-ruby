# typed: strong

module OpenAI
  module Models
    class FileCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The File object (not file name) to be uploaded.
      sig { returns(T.any(IO, StringIO)) }
      def file
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def file=(_)
      end

      # The intended purpose of the uploaded file.
      #
      #   Use "assistants" for
      #   [Assistants](https://platform.openai.com/docs/api-reference/assistants) and
      #   [Message](https://platform.openai.com/docs/api-reference/messages) files,
      #   "vision" for Assistants image file inputs, "batch" for
      #   [Batch API](https://platform.openai.com/docs/guides/batch), and "fine-tune" for
      #   [Fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning).
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
