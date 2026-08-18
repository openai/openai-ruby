# typed: strong

module OpenAI
  module Models
    BetaFunctionShellTool = Beta::BetaFunctionShellTool

    module Beta
      class BetaFunctionShellTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaFunctionShellTool,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the shell tool. Always `shell`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The tool invocation context(s).
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Beta::BetaFunctionShellTool::AllowedCaller::OrSymbol
              ]
            )
          )
        end
        attr_accessor :allowed_callers

        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::BetaContainerAuto,
                OpenAI::Beta::BetaLocalEnvironment,
                OpenAI::Beta::BetaContainerReference
              )
            )
          )
        end
        attr_accessor :environment

        # A tool that allows the model to execute shell commands.
        sig do
          params(
            allowed_callers:
              T.nilable(
                T::Array[
                  OpenAI::Beta::BetaFunctionShellTool::AllowedCaller::OrSymbol
                ]
              ),
            environment:
              T.nilable(
                T.any(
                  OpenAI::Beta::BetaContainerAuto::OrHash,
                  OpenAI::Beta::BetaLocalEnvironment::OrHash,
                  OpenAI::Beta::BetaContainerReference::OrHash
                )
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The tool invocation context(s).
          allowed_callers: nil,
          environment: nil,
          # The type of the shell tool. Always `shell`.
          type: :shell
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              allowed_callers:
                T.nilable(
                  T::Array[
                    OpenAI::Beta::BetaFunctionShellTool::AllowedCaller::OrSymbol
                  ]
                ),
              environment:
                T.nilable(
                  T.any(
                    OpenAI::Beta::BetaContainerAuto,
                    OpenAI::Beta::BetaLocalEnvironment,
                    OpenAI::Beta::BetaContainerReference
                  )
                )
            }
          )
        end
        def to_hash
        end

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaFunctionShellTool::AllowedCaller)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DIRECT =
            T.let(
              :direct,
              OpenAI::Beta::BetaFunctionShellTool::AllowedCaller::TaggedSymbol
            )
          PROGRAMMATIC =
            T.let(
              :programmatic,
              OpenAI::Beta::BetaFunctionShellTool::AllowedCaller::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaFunctionShellTool::AllowedCaller::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Environment
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaContainerAuto,
                OpenAI::Beta::BetaLocalEnvironment,
                OpenAI::Beta::BetaContainerReference
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaFunctionShellTool::Environment::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
