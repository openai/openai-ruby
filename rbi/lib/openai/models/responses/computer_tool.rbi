# typed: strong

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::Internal::Type::BaseModel
        # The height of the computer display.
        sig { returns(Float) }
        attr_accessor :display_height

        # The width of the computer display.
        sig { returns(Float) }
        attr_accessor :display_width

        # The type of computer environment to control.
        sig { returns(OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol) }
        attr_accessor :environment

        # The type of the computer use tool. Always `computer_use_preview`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A tool that controls a virtual computer. Learn more about the
        # [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        sig do
          params(
            display_height: Float,
            display_width: Float,
            environment: OpenAI::Models::Responses::ComputerTool::Environment::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(display_height:, display_width:, environment:, type: :computer_use_preview); end

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
        def to_hash; end

        # The type of computer environment to control.
        module Environment
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ComputerTool::Environment) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MAC = T.let(:mac, OpenAI::Models::Responses::ComputerTool::Environment::TaggedSymbol)
          WINDOWS = T.let(:windows, OpenAI::Models::Responses::ComputerTool::Environment::TaggedSymbol)
          UBUNTU = T.let(:ubuntu, OpenAI::Models::Responses::ComputerTool::Environment::TaggedSymbol)
          BROWSER = T.let(:browser, OpenAI::Models::Responses::ComputerTool::Environment::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ComputerTool::Environment::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
