# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    # The intended purpose of the uploaded file.
    #
    #   Use "assistants" for
    #   [Assistants](https://platform.openai.com/docs/api-reference/assistants) and
    #   [Message](https://platform.openai.com/docs/api-reference/messages) files,
    #   "vision" for Assistants image file inputs, "batch" for
    #   [Batch API](https://platform.openai.com/docs/guides/batch), and "fine-tune" for
    #   [Fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning).
    class FilePurpose < OpenAI::Enum
      ASSISTANTS = :assistants
      BATCH = :batch
      FINE_TUNE = :"fine-tune"
      VISION = :vision

      finalize!
    end
  end
end
