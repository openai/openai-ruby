# typed: strong

module OpenAI
  module Models
    # The intended purpose of the uploaded file.
    #
    #   Use "assistants" for
    #   [Assistants](https://platform.openai.com/docs/api-reference/assistants) and
    #   [Message](https://platform.openai.com/docs/api-reference/messages) files,
    #   "vision" for Assistants image file inputs, "batch" for
    #   [Batch API](https://platform.openai.com/docs/guides/batch), and "fine-tune" for
    #   [Fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning).
    class FilePurpose < OpenAI::Enum
      abstract!

      ASSISTANTS = :assistants
      BATCH = :batch
      FINE_TUNE = :"fine-tune"
      VISION = :vision

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
