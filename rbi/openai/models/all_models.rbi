# typed: strong

module OpenAI
  module Models
    module AllModels
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            String,
            OpenAI::ChatModel::TaggedSymbol,
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        end

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::AllModels::ResponsesOnlyModel) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        O1_PRO =
          T.let(:"o1-pro", OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol)
        O1_PRO_2025_03_19 =
          T.let(
            :"o1-pro-2025-03-19",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        O3_PRO =
          T.let(:"o3-pro", OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol)
        O3_PRO_2025_06_10 =
          T.let(
            :"o3-pro-2025-06-10",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        O3_DEEP_RESEARCH =
          T.let(
            :"o3-deep-research",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        O3_DEEP_RESEARCH_2025_06_26 =
          T.let(
            :"o3-deep-research-2025-06-26",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        O4_MINI_DEEP_RESEARCH =
          T.let(
            :"o4-mini-deep-research",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        O4_MINI_DEEP_RESEARCH_2025_06_26 =
          T.let(
            :"o4-mini-deep-research-2025-06-26",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        COMPUTER_USE_PREVIEW =
          T.let(
            :"computer-use-preview",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        COMPUTER_USE_PREVIEW_2025_03_11 =
          T.let(
            :"computer-use-preview-2025-03-11",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )
        GPT_5_CODEX =
          T.let(
            :"gpt-5-codex",
            OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::AllModels::ResponsesOnlyModel::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      sig { override.returns(T::Array[OpenAI::AllModels::Variants]) }
      def self.variants
      end
    end
  end
end
