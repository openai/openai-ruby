# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionShellTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::FunctionShellTool,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the shell tool. Always `shell`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ContainerAuto,
                OpenAI::Responses::LocalEnvironment,
                OpenAI::Responses::ContainerReference
              )
            )
          )
        end
        attr_accessor :environment

        # A tool that allows the model to execute shell commands.
        sig do
          params(
            environment:
              T.nilable(
                T.any(
                  OpenAI::Responses::ContainerAuto::OrHash,
                  OpenAI::Responses::LocalEnvironment::OrHash,
                  OpenAI::Responses::ContainerReference::OrHash
                )
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          environment: nil,
          # The type of the shell tool. Always `shell`.
          type: :shell
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              environment:
                T.nilable(
                  T.any(
                    OpenAI::Responses::ContainerAuto,
                    OpenAI::Responses::LocalEnvironment,
                    OpenAI::Responses::ContainerReference
                  )
                )
            }
          )
        end
        def to_hash
        end

        module Environment
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ContainerAuto,
                OpenAI::Responses::LocalEnvironment,
                OpenAI::Responses::ContainerReference
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::FunctionShellTool::Environment::Variants
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
