# frozen_string_literal: true

module OpenAI
  module Models
    class Reasoning < OpenAI::Internal::Type::BaseModel
      # @!attribute context
      #   Controls which reasoning items are rendered back to the model on later turns. If
      #   omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
      #   model family defaults to `all_turns`; earlier models default to `current_turn`.
      #
      #   When returned on a response, this is the effective reasoning context mode used
      #   for the response.
      #
      #   @return [Symbol, OpenAI::Models::Reasoning::Context, nil]
      optional :context, enum: -> { OpenAI::Reasoning::Context }, nil?: true

      # @!attribute effort
      #   Constrains effort on reasoning for reasoning models. Currently supported values
      #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
      #   reasoning effort can result in faster responses and fewer tokens used on
      #   reasoning in a response. Not all reasoning models support every value. See the
      #   [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
      #   model-specific support.
      #
      #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
      optional :effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

      # @!attribute generate_summary
      #   @deprecated
      #
      #   **Deprecated:** use `summary` instead.
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `auto`,
      #   `concise`, or `detailed`.
      #
      #   @return [Symbol, OpenAI::Models::Reasoning::GenerateSummary, nil]
      optional :generate_summary, enum: -> { OpenAI::Reasoning::GenerateSummary }, nil?: true

      # @!attribute mode
      #   Controls the reasoning execution mode for the request.
      #
      #   When returned on a response, this is the effective execution mode.
      #
      #   @return [String, Symbol, OpenAI::Models::Reasoning::Mode, nil]
      optional :mode, union: -> { OpenAI::Reasoning::Mode }

      # @!attribute summary
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `auto`,
      #   `concise`, or `detailed`.
      #
      #   `concise` is supported for `computer-use-preview` models and all reasoning
      #   models after `gpt-5`.
      #
      #   @return [Symbol, OpenAI::Models::Reasoning::Summary, nil]
      optional :summary, enum: -> { OpenAI::Reasoning::Summary }, nil?: true

      # @!method initialize(context: nil, effort: nil, generate_summary: nil, mode: nil, summary: nil)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::Reasoning} for more details.
      #
      #   **gpt-5 and o-series models only**
      #
      #   Configuration options for
      #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      #
      #   @param context [Symbol, OpenAI::Models::Reasoning::Context, nil] Controls which reasoning items are rendered back to the model on later turns.
      #
      #   @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil] Constrains effort on reasoning for reasoning models. Currently supported
      #
      #   @param generate_summary [Symbol, OpenAI::Models::Reasoning::GenerateSummary, nil] **Deprecated:** use `summary` instead.
      #
      #   @param mode [String, Symbol, OpenAI::Models::Reasoning::Mode] Controls the reasoning execution mode for the request.
      #
      #   @param summary [Symbol, OpenAI::Models::Reasoning::Summary, nil] A summary of the reasoning performed by the model. This can be

      # Controls which reasoning items are rendered back to the model on later turns. If
      # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
      # model family defaults to `all_turns`; earlier models default to `current_turn`.
      #
      # When returned on a response, this is the effective reasoning context mode used
      # for the response.
      #
      # @see OpenAI::Models::Reasoning#context
      module Context
        extend OpenAI::Internal::Type::Enum

        AUTO = :auto
        CURRENT_TURN = :current_turn
        ALL_TURNS = :all_turns

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @deprecated
      #
      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      #
      # @see OpenAI::Models::Reasoning#generate_summary
      module GenerateSummary
        extend OpenAI::Internal::Type::Enum

        AUTO = :auto
        CONCISE = :concise
        DETAILED = :detailed

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # Controls the reasoning execution mode for the request.
      #
      # When returned on a response, this is the effective execution mode.
      #
      # @see OpenAI::Models::Reasoning#mode
      module Mode
        extend OpenAI::Internal::Type::Union

        variant String

        variant const: -> { OpenAI::Models::Reasoning::Mode::STANDARD }

        variant const: -> { OpenAI::Models::Reasoning::Mode::PRO }

        # @!method self.variants
        #   @return [Array(String, Symbol)]

        define_sorbet_constant!(:Variants) do
          T.type_alias { T.any(String, OpenAI::Reasoning::Mode::TaggedSymbol) }
        end

        # @!group

        STANDARD = :standard
        PRO = :pro

        # @!endgroup
      end

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      #
      # `concise` is supported for `computer-use-preview` models and all reasoning
      # models after `gpt-5`.
      #
      # @see OpenAI::Models::Reasoning#summary
      module Summary
        extend OpenAI::Internal::Type::Enum

        AUTO = :auto
        CONCISE = :concise
        DETAILED = :detailed

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
