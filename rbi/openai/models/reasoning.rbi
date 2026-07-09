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

      # Constrains effort on reasoning for reasoning models. Currently supported values
      # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
      # reasoning effort can result in faster responses and fewer tokens used on
      # reasoning in a response. Not all reasoning models support every value. See the
      # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
      # model-specific support.
      sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
      attr_accessor :effort

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      sig { returns(T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol)) }
      attr_accessor :generate_summary

      # Controls the reasoning execution mode for the request.
      #
      # When returned on a response, this is the effective execution mode.
      sig do
        returns(T.nilable(T.any(String, OpenAI::Reasoning::Mode::OrSymbol)))
      end
      attr_reader :mode

      sig do
        params(mode: T.any(String, OpenAI::Reasoning::Mode::OrSymbol)).void
      end
      attr_writer :mode

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
          mode: T.any(String, OpenAI::Reasoning::Mode::OrSymbol),
          summary: T.nilable(OpenAI::Reasoning::Summary::OrSymbol)
        ).returns(T.attached_class)
      end
      def self.new(
        # Controls which reasoning items are rendered back to the model on later turns.
        # When returned on a response, this is the effective reasoning context mode used
        # for the response.
        context: nil,
        # Constrains effort on reasoning for reasoning models. Currently supported values
        # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
        # reasoning effort can result in faster responses and fewer tokens used on
        # reasoning in a response. Not all reasoning models support every value. See the
        # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
        # model-specific support.
        effort: nil,
        # **Deprecated:** use `summary` instead.
        #
        # A summary of the reasoning performed by the model. This can be useful for
        # debugging and understanding the model's reasoning process. One of `auto`,
        # `concise`, or `detailed`.
        generate_summary: nil,
        # Controls the reasoning execution mode for the request.
        #
        # When returned on a response, this is the effective execution mode.
        mode: nil,
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
            mode: T.any(String, OpenAI::Reasoning::Mode::OrSymbol),
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

      # Controls the reasoning execution mode for the request.
      #
      # When returned on a response, this is the effective execution mode.
      module Mode
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias { T.any(String, OpenAI::Reasoning::Mode::TaggedSymbol) }

        sig { override.returns(T::Array[OpenAI::Reasoning::Mode::Variants]) }
        def self.variants
        end

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Reasoning::Mode) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        STANDARD = T.let(:standard, OpenAI::Reasoning::Mode::TaggedSymbol)
        PRO = T.let(:pro, OpenAI::Reasoning::Mode::TaggedSymbol)
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
