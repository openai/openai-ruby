# typed: strong

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::BaseModel
        # The height of the computer display.
        sig { returns(Float) }
        def display_height
        end

        sig { params(_: Float).returns(Float) }
        def display_height=(_)
        end

        # The width of the computer display.
        sig { returns(Float) }
        def display_width
        end

        sig { params(_: Float).returns(Float) }
        def display_width=(_)
        end

        # The type of computer environment to control.
        sig { returns(OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol) }
        def environment
        end

        sig do
          params(_: OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol)
            .returns(OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol)
        end
        def environment=(_)
        end

        # The type of the computer use tool. Always `computer_use_preview`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A tool that controls a virtual computer. Learn more about the
        #   [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        sig do
          params(
            display_height: Float,
            display_width: Float,
            environment: OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(display_height:, display_width:, environment:, type: :computer_use_preview)
        end

        sig do
          override
            .returns(
              {
                display_height: Float,
                display_width: Float,
                environment: OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # The type of computer environment to control.
        module Environment
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ComputerTool::Environment) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ComputerTool::Environment::TaggedSymbol) }

          MAC = T.let(:mac, OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol)
          WINDOWS = T.let(:windows, OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol)
          UBUNTU = T.let(:ubuntu, OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol)
          BROWSER = T.let(:browser, OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol)
        end
      end
    end
  end
end
