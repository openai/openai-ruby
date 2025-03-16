# typed: strong

module OpenAI
  module Models
    # The intended purpose of the uploaded file. One of: - `assistants`: Used in the
    #   Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
    #   fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
    #   Flexible file type for any purpose - `evals`: Used for eval data sets
    class FilePurpose < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      ASSISTANTS = :assistants
      BATCH = :batch
      FINE_TUNE = :"fine-tune"
      VISION = :vision
      USER_DATA = :user_data
      EVALS = :evals
    end
  end
end
