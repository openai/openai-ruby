# typed: strong

module OpenAI
  module Models
    class Reasoning < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias { T.any(OpenAI::Reasoning, OpenAI::Internal::AnyHash) }

      # Controls which reasoning items are rendered back to the model on later turns.
      # When returned on a response, this is the effective reasoning context mode used
      # for the response.
      sig { returns(T.nilable(OpenAI::Reasoning::Context::OrSymbol)) }
      attr_accessor :context

      # Constrains effort on reasoning for
      # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
      # Reducing reasoning effort can result in faster responses and fewer tokens used
      # on reasoning in a response.
      #
      # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
      #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
      #   calls are supported for all reasoning values in gpt-5.1.
      # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
      #   support `none`.
      # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
      # - `xhigh` is supported for all models after `gpt-5.1-codex-max`.
      sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
      attr_accessor :effort

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      sig { returns(T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol)) }
      attr_accessor :generate_summary

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      #
      # `concise` is supported for `computer-use-preview` models and all reasoning
      # models after `gpt-5`.
      sig { returns(T.nilable(OpenAI::Reasoning::Summary::OrSymbol)) }
      attr_accessor :summary

      # **gpt-5 and o-series models only**
      #
      # Configuration options for
      # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      sig do
        params(
          context: T.nilable(OpenAI::Reasoning::Context::OrSymbol),
          effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
          generate_summary:
            T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol),
          summary: T.nilable(OpenAI::Reasoning::Summary::OrSymbol)
        ).returns(T.attached_class)
      end
      def self.new(
        # Controls which reasoning items are rendered back to the model on later turns.
        # When returned on a response, this is the effective reasoning context mode used
        # for the response.
        context: nil,
        # Constrains effort on reasoning for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
        # Reducing reasoning effort can result in faster responses and fewer tokens used
        # on reasoning in a response.
        #
        # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
        #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
        #   calls are supported for all reasoning values in gpt-5.1.
        # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
        #   support `none`.
        # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
        # - `xhigh` is supported for all models after `gpt-5.1-codex-max`.
        effort: nil,
        # **Deprecated:** use `summary` instead.
        #
        # A summary of the reasoning performed by the model. This can be useful for
        # debugging and understanding the model's reasoning process. One of `auto`,
        # `concise`, or `detailed`.
        generate_summary: nil,
        # A summary of the reasoning performed by the model. This can be useful for
        # debugging and understanding the model's reasoning process. One of `auto`,
        # `concise`, or `detailed`.
        #
        # `concise` is supported for `computer-use-preview` models and all reasoning
        # models after `gpt-5`.
        summary: nil
      )
      end

      sig do
        override.returns(
          {
            context: T.nilable(OpenAI::Reasoning::Context::OrSymbol),
            effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
            generate_summary:
              T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol),
            summary: T.nilable(OpenAI::Reasoning::Summary::OrSymbol)
          }
        )
      end
      def to_hash
      end

      # Controls which reasoning items are rendered back to the model on later turns.
      # When returned on a response, this is the effective reasoning context mode used
      # for the response.
      module Context
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Reasoning::Context) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        AUTO = T.let(:auto, OpenAI::Reasoning::Context::TaggedSymbol)
        CURRENT_TURN =
          T.let(:current_turn, OpenAI::Reasoning::Context::TaggedSymbol)
        ALL_TURNS = T.let(:all_turns, OpenAI::Reasoning::Context::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::Reasoning::Context::TaggedSymbol])
        end
        def self.values
        end
      end

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      module GenerateSummary
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Reasoning::GenerateSummary) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        AUTO = T.let(:auto, OpenAI::Reasoning::GenerateSummary::TaggedSymbol)
        CONCISE =
          T.let(:concise, OpenAI::Reasoning::GenerateSummary::TaggedSymbol)
        DETAILED =
          T.let(:detailed, OpenAI::Reasoning::GenerateSummary::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Reasoning::GenerateSummary::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      #
      # `concise` is supported for `computer-use-preview` models and all reasoning
      # models after `gpt-5`.
      module Summary
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Reasoning::Summary) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        AUTO = T.let(:auto, OpenAI::Reasoning::Summary::TaggedSymbol)
        CONCISE = T.let(:concise, OpenAI::Reasoning::Summary::TaggedSymbol)
        DETAILED = T.let(:detailed, OpenAI::Reasoning::Summary::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::Reasoning::Summary::TaggedSymbol])
        end
        def self.values
        end
      end
    end
  end
end
