# typed: strong

module OpenAI
  module Models
    module Responses
      class CustomTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::CustomTool, OpenAI::Internal::AnyHash)
          end

        # The name of the custom tool, used to identify it in tool calls.
        sig { returns(String) }
        attr_accessor :name

        # The type of the custom tool. Always `custom`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional description of the custom tool, used to provide more context.
        sig { returns(T.nilable(String)) }
        attr_reader :description

        sig { params(description: String).void }
        attr_writer :description

        # The input format for the custom tool. Default is unconstrained text.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::CustomToolInputFormat::Text,
                OpenAI::CustomToolInputFormat::Grammar
              )
            )
          )
        end
        attr_reader :format_

        sig do
          params(
            format_:
              T.any(
                OpenAI::CustomToolInputFormat::Text::OrHash,
                OpenAI::CustomToolInputFormat::Grammar::OrHash
              )
          ).void
        end
        attr_writer :format_

        # A custom tool that processes input using a specified format. Learn more about
        # [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
        sig do
          params(
            name: String,
            description: String,
            format_:
              T.any(
                OpenAI::CustomToolInputFormat::Text::OrHash,
                OpenAI::CustomToolInputFormat::Grammar::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the custom tool, used to identify it in tool calls.
          name:,
          # Optional description of the custom tool, used to provide more context.
          description: nil,
          # The input format for the custom tool. Default is unconstrained text.
          format_: nil,
          # The type of the custom tool. Always `custom`.
          type: :custom
        )
        end

        sig do
          override.returns(
            {
              name: String,
              type: Symbol,
              description: String,
              format_:
                T.any(
                  OpenAI::CustomToolInputFormat::Text,
                  OpenAI::CustomToolInputFormat::Grammar
                )
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
