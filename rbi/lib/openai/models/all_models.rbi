# typed: strong

module OpenAI
  module Models
    class AllModels < OpenAI::Union
      abstract!

      Variants = type_template(:out) { {fixed: T.any(String, Symbol)} }

      class UnionMember2 < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        O1_PRO = :"o1-pro"
        O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
        COMPUTER_USE_PREVIEW = :"computer-use-preview"
        COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"
      end
    end
  end
end
