# typed: strong

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The height of the computer display.
        sig { returns(Integer) }
        attr_accessor :display_height

        # The width of the computer display.
        sig { returns(Integer) }
        attr_accessor :display_width

        # The type of computer environment to control.
        sig { returns(OpenAI::Responses::ComputerTool::Environment::OrSymbol) }
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
            environment: OpenAI::Responses::ComputerTool::Environment::OrSymbol,
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
                OpenAI::Responses::ComputerTool::Environment::OrSymbol,
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
              T.all(Symbol, OpenAI::Responses::ComputerTool::Environment)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WINDOWS =
            T.let(
              :windows,
              OpenAI::Responses::ComputerTool::Environment::TaggedSymbol
            )
          MAC =
            T.let(
              :mac,
              OpenAI::Responses::ComputerTool::Environment::TaggedSymbol
            )
          LINUX =
            T.let(
              :linux,
              OpenAI::Responses::ComputerTool::Environment::TaggedSymbol
            )
          UBUNTU =
            T.let(
              :ubuntu,
              OpenAI::Responses::ComputerTool::Environment::TaggedSymbol
            )
          BROWSER =
            T.let(
              :browser,
              OpenAI::Responses::ComputerTool::Environment::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ComputerTool::Environment::TaggedSymbol
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
