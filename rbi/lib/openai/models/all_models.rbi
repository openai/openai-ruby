# typed: strong

module OpenAI
  module Models
    module AllModels
      extend OpenAI::Union

      sig { override.returns([String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::AllModels::OrSymbol]) }
      def self.variants
      end

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AllModels) }
      OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::AllModels::TaggedSymbol) }

      O1_PRO = T.let(:"o1-pro", OpenAI::Models::AllModels::TaggedSymbol)
      O1_PRO_2025_03_19 = T.let(:"o1-pro-2025-03-19", OpenAI::Models::AllModels::TaggedSymbol)
      COMPUTER_USE_PREVIEW = T.let(:"computer-use-preview", OpenAI::Models::AllModels::TaggedSymbol)
      COMPUTER_USE_PREVIEW_2025_03_11 =
        T.let(:"computer-use-preview-2025-03-11", OpenAI::Models::AllModels::TaggedSymbol)
    end
  end
end
