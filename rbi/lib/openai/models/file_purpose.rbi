# typed: strong

module OpenAI
  module Models
    class FilePurpose < OpenAI::Enum
      abstract!

      ASSISTANTS = :assistants
      BATCH = :batch
      FINE_TUNE = :"fine-tune"
      VISION = :vision
      USER_DATA = :user_data
      EVALS = :evals

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
