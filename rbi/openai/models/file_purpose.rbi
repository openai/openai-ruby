# typed: strong

module OpenAI
  module Models
    # The intended purpose of the uploaded file. One of:
    #
    # - `assistants`: Used in the Assistants API
    # - `batch`: Used in the Batch API
    # - `fine-tune`: Used for fine-tuning
    # - `vision`: Images used for vision fine-tuning
    # - `user_data`: Flexible file type for any purpose
    # - `evals`: Used for eval data sets
    module FilePurpose
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::FilePurpose) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      ASSISTANTS = T.let(:assistants, OpenAI::FilePurpose::TaggedSymbol)
      BATCH = T.let(:batch, OpenAI::FilePurpose::TaggedSymbol)
      FINE_TUNE = T.let(:"fine-tune", OpenAI::FilePurpose::TaggedSymbol)
      VISION = T.let(:vision, OpenAI::FilePurpose::TaggedSymbol)
      USER_DATA = T.let(:user_data, OpenAI::FilePurpose::TaggedSymbol)
      EVALS = T.let(:evals, OpenAI::FilePurpose::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::FilePurpose::TaggedSymbol]) }
      def self.values
      end
    end
  end
end
