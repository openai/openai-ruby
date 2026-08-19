# typed: strong

module OpenAI
  module Models

    module ResponsesModel
      extend OpenAI::Internal::Type::Union

      Variants = T.type_alias do
        T.any(
          String,
          OpenAI::ChatModel::TaggedSymbol,
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
      end

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ResponsesModel::ResponsesOnlyModel) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        O1_PRO = T.let(:"o1-pro", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        O1_PRO_2025_03_19 = T.let(:"o1-pro-2025-03-19", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        O3_PRO = T.let(:"o3-pro", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        O3_PRO_2025_06_10 = T.let(:"o3-pro-2025-06-10", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        O3_DEEP_RESEARCH = T.let(:"o3-deep-research", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        O3_DEEP_RESEARCH_2025_06_26 = T.let(
          :"o3-deep-research-2025-06-26",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        O4_MINI_DEEP_RESEARCH = T.let(
          :"o4-mini-deep-research",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        O4_MINI_DEEP_RESEARCH_2025_06_26 = T.let(
          :"o4-mini-deep-research-2025-06-26",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        COMPUTER_USE_PREVIEW = T.let(:"computer-use-preview", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        COMPUTER_USE_PREVIEW_2025_03_11 = T.let(
          :"computer-use-preview-2025-03-11",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        GPT_5_5_PRO = T.let(:"gpt-5.5-pro", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        GPT_5_5_PRO_2026_04_23 = T.let(
          :"gpt-5.5-pro-2026-04-23",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        GPT_5_CODEX = T.let(:"gpt-5-codex", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        GPT_5_PRO = T.let(:"gpt-5-pro", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        GPT_5_PRO_2025_10_06 = T.let(:"gpt-5-pro-2025-10-06", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        GPT_5_1_CODEX_MAX = T.let(:"gpt-5.1-codex-max", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)
        GPT_DAYBREAK_BLUE_LATEST = T.let(
          :"gpt-daybreak-blue-latest",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        GPT_DAYBREAK_RED_LATEST = T.let(
          :"gpt-daybreak-red-latest",
          OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
        )
        GPT_5_6_CYBER = T.let(:"gpt-5.6-cyber", OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol]) }
        def self.values
        end
      end

      sig { override.returns(T::Array[OpenAI::ResponsesModel::Variants]) }
      def self.variants
      end

    end

  end
end
