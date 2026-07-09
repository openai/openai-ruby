# typed: strong

module OpenAI
  module Models
    BetaApplyPatchTool = Beta::BetaApplyPatchTool

    module Beta
      class BetaApplyPatchTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::BetaApplyPatchTool, OpenAI::Internal::AnyHash)
          end

        # The type of the tool. Always `apply_patch`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The tool invocation context(s).
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Beta::BetaApplyPatchTool::AllowedCaller::OrSymbol
              ]
            )
          )
        end
        attr_accessor :allowed_callers

        # Allows the assistant to create, delete, or update files using unified diffs.
        sig do
          params(
            allowed_callers:
              T.nilable(
                T::Array[
                  OpenAI::Beta::BetaApplyPatchTool::AllowedCaller::OrSymbol
                ]
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The tool invocation context(s).
          allowed_callers: nil,
          # The type of the tool. Always `apply_patch`.
          type: :apply_patch
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              allowed_callers:
                T.nilable(
                  T::Array[
                    OpenAI::Beta::BetaApplyPatchTool::AllowedCaller::OrSymbol
                  ]
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
              T.all(Symbol, OpenAI::Beta::BetaApplyPatchTool::AllowedCaller)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DIRECT =
            T.let(
              :direct,
              OpenAI::Beta::BetaApplyPatchTool::AllowedCaller::TaggedSymbol
            )
          PROGRAMMATIC =
            T.let(
              :programmatic,
              OpenAI::Beta::BetaApplyPatchTool::AllowedCaller::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaApplyPatchTool::AllowedCaller::TaggedSymbol
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
