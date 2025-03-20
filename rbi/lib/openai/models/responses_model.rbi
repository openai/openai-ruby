# typed: strong

module OpenAI
  module Models
    module ResponsesModel
      extend OpenAI::Union

      Variants =
        type_template(:out) { {fixed: T.any(String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::ResponsesModel::OrSymbol)} }

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ResponsesModel) }
      OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ResponsesModel::TaggedSymbol) }

      O1_PRO = T.let(:"o1-pro", OpenAI::Models::ResponsesModel::OrSymbol)
      O1_PRO_2025_03_19 = T.let(:"o1-pro-2025-03-19", OpenAI::Models::ResponsesModel::OrSymbol)
      COMPUTER_USE_PREVIEW = T.let(:"computer-use-preview", OpenAI::Models::ResponsesModel::OrSymbol)
      COMPUTER_USE_PREVIEW_2025_03_11 =
        T.let(:"computer-use-preview-2025-03-11", OpenAI::Models::ResponsesModel::OrSymbol)
    end
  end
end
