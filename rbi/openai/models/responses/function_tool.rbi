# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::FunctionTool, OpenAI::Internal::AnyHash)
          end

        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # A JSON schema object describing the parameters of the function.
        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        attr_accessor :parameters

        # Whether strict parameter validation is enforced for this function tool.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :strict

        # The type of the function tool. Always `function`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The tool invocation context(s).
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Responses::FunctionTool::AllowedCaller::OrSymbol]
            )
          )
        end
        attr_accessor :allowed_callers

        # Whether this function is deferred and loaded via tool search.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :defer_loading

        sig { params(defer_loading: T::Boolean).void }
        attr_writer :defer_loading

        # A description of the function. Used by the model to determine whether or not to
        # call the function.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # A JSON schema object describing the JSON value encoded in string outputs for
        # this function.
        sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
        attr_accessor :output_schema

        # Defines a function in your own code the model can choose to call. Learn more
        # about
        # [function calling](https://platform.openai.com/docs/guides/function-calling).
        sig do
          params(
            name: String,
            parameters: T.nilable(T::Hash[Symbol, T.anything]),
            strict: T.nilable(T::Boolean),
            allowed_callers:
              T.nilable(
                T::Array[
                  OpenAI::Responses::FunctionTool::AllowedCaller::OrSymbol
                ]
              ),
            defer_loading: T::Boolean,
            description: T.nilable(String),
            output_schema: T.nilable(T::Hash[Symbol, T.anything]),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the function to call.
          name:,
          # A JSON schema object describing the parameters of the function.
          parameters:,
          # Whether strict parameter validation is enforced for this function tool.
          strict:,
          # The tool invocation context(s).
          allowed_callers: nil,
          # Whether this function is deferred and loaded via tool search.
          defer_loading: nil,
          # A description of the function. Used by the model to determine whether or not to
          # call the function.
          description: nil,
          # A JSON schema object describing the JSON value encoded in string outputs for
          # this function.
          output_schema: nil,
          # The type of the function tool. Always `function`.
          type: :function
        )
        end

        sig do
          override.returns(
            {
              name: String,
              parameters: T.nilable(T::Hash[Symbol, T.anything]),
              strict: T.nilable(T::Boolean),
              type: Symbol,
              allowed_callers:
                T.nilable(
                  T::Array[
                    OpenAI::Responses::FunctionTool::AllowedCaller::OrSymbol
                  ]
                ),
              defer_loading: T::Boolean,
              description: T.nilable(String),
              output_schema: T.nilable(T::Hash[Symbol, T.anything])
            }
          )
        end
        def to_hash
        end

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::FunctionTool::AllowedCaller)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DIRECT =
            T.let(
              :direct,
              OpenAI::Responses::FunctionTool::AllowedCaller::TaggedSymbol
            )
          PROGRAMMATIC =
            T.let(
              :programmatic,
              OpenAI::Responses::FunctionTool::AllowedCaller::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::FunctionTool::AllowedCaller::TaggedSymbol
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
