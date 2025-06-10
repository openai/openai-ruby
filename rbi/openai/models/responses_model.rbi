# typed: strong

module OpenAI
  module Models
    module ResponsesModel
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            String,
            OpenAI::ChatModel::TaggedSymbol,
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )
        end

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ResponsesModel::ResponsesOnlyModel)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        O1_PRO =
          T.let(
            :"o1-pro",
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )
        O1_PRO_2025_03_19 =
          T.let(
            :"o1-pro-2025-03-19",
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )
        O3_PRO =
          T.let(
            :"o3-pro",
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )
        O3_PRO_2025_06_10 =
          T.let(
            :"o3-pro-2025-06-10",
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )
        COMPUTER_USE_PREVIEW =
          T.let(
            :"computer-use-preview",
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )
        COMPUTER_USE_PREVIEW_2025_03_11 =
          T.let(
            :"computer-use-preview-2025-03-11",
            OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::ResponsesModel::ResponsesOnlyModel::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      sig { override.returns(T::Array[OpenAI::ResponsesModel::Variants]) }
      def self.variants
      end
    end
  end
end
