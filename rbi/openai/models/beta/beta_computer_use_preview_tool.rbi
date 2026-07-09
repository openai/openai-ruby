# typed: strong

module OpenAI
  module Models
    BetaComputerUsePreviewTool = Beta::BetaComputerUsePreviewTool

    module Beta
      class BetaComputerUsePreviewTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaComputerUsePreviewTool,
              OpenAI::Internal::AnyHash
            )
          end

        # The height of the computer display.
        sig { returns(Integer) }
        attr_accessor :display_height

        # The width of the computer display.
        sig { returns(Integer) }
        attr_accessor :display_width

        # The type of computer environment to control.
        sig do
          returns(
            OpenAI::Beta::BetaComputerUsePreviewTool::Environment::OrSymbol
          )
        end
        attr_accessor :environment

        # The type of the computer use tool. Always `computer_use_preview`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A tool that controls a virtual computer. Learn more about the
        # [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        sig do
          params(
            display_height: Integer,
            display_width: Integer,
            environment:
              OpenAI::Beta::BetaComputerUsePreviewTool::Environment::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The height of the computer display.
          display_height:,
          # The width of the computer display.
          display_width:,
          # The type of computer environment to control.
          environment:,
          # The type of the computer use tool. Always `computer_use_preview`.
          type: :computer_use_preview
        )
        end

        sig do
          override.returns(
            {
              display_height: Integer,
              display_width: Integer,
              environment:
                OpenAI::Beta::BetaComputerUsePreviewTool::Environment::OrSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The type of computer environment to control.
        module Environment
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Beta::BetaComputerUsePreviewTool::Environment
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WINDOWS =
            T.let(
              :windows,
              OpenAI::Beta::BetaComputerUsePreviewTool::Environment::TaggedSymbol
            )
          MAC =
            T.let(
              :mac,
              OpenAI::Beta::BetaComputerUsePreviewTool::Environment::TaggedSymbol
            )
          LINUX =
            T.let(
              :linux,
              OpenAI::Beta::BetaComputerUsePreviewTool::Environment::TaggedSymbol
            )
          UBUNTU =
            T.let(
              :ubuntu,
              OpenAI::Beta::BetaComputerUsePreviewTool::Environment::TaggedSymbol
            )
          BROWSER =
            T.let(
              :browser,
              OpenAI::Beta::BetaComputerUsePreviewTool::Environment::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaComputerUsePreviewTool::Environment::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
