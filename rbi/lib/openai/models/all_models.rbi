# typed: strong

module OpenAI
  module Models
    module AllModels
      extend OpenAI::Internal::Type::Union

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AllModels::ResponsesOnlyModel) }
        OrSymbol =
          T.type_alias { T.any(Symbol, String, OpenAI::Models::AllModels::ResponsesOnlyModel::TaggedSymbol) }

        O1_PRO = T.let(:"o1-pro", OpenAI::Models::AllModels::ResponsesOnlyModel::TaggedSymbol)
        O1_PRO_2025_03_19 =
          T.let(:"o1-pro-2025-03-19", OpenAI::Models::AllModels::ResponsesOnlyModel::TaggedSymbol)
        COMPUTER_USE_PREVIEW =
          T.let(:"computer-use-preview", OpenAI::Models::AllModels::ResponsesOnlyModel::TaggedSymbol)
        COMPUTER_USE_PREVIEW_2025_03_11 =
          T.let(:"computer-use-preview-2025-03-11", OpenAI::Models::AllModels::ResponsesOnlyModel::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::AllModels::ResponsesOnlyModel::TaggedSymbol]) }
        def self.values; end
      end

      sig do
        override
          .returns(
            [String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::AllModels::ResponsesOnlyModel::OrSymbol]
          )
      end
      def self.variants; end
    end
  end
end
