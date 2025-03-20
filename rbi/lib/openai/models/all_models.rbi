# typed: strong

module OpenAI
  module Models
    module AllModels
      extend OpenAI::Union

      Variants =
        type_template(:out) do
          {
            fixed: T.any(String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::AllModels::UnionMember2::OrSymbol)
          }
        end

      module UnionMember2
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AllModels::UnionMember2) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::AllModels::UnionMember2::TaggedSymbol) }

        O1_PRO = T.let(:"o1-pro", OpenAI::Models::AllModels::UnionMember2::OrSymbol)
        O1_PRO_2025_03_19 = T.let(:"o1-pro-2025-03-19", OpenAI::Models::AllModels::UnionMember2::OrSymbol)
        COMPUTER_USE_PREVIEW = T.let(:"computer-use-preview", OpenAI::Models::AllModels::UnionMember2::OrSymbol)
        COMPUTER_USE_PREVIEW_2025_03_11 =
          T.let(:"computer-use-preview-2025-03-11", OpenAI::Models::AllModels::UnionMember2::OrSymbol)
      end
    end
  end
end
