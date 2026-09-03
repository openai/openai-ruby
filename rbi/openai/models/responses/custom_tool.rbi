# typed: strong

module OpenAI
  module Models

    module Responses

      class CustomTool < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::CustomTool,
            OpenAI::Internal::AnyHash
          )
        end

        # The name of the custom tool, used to identify it in tool calls.
        sig { returns(String) }
        attr_accessor :name

        # The type of the custom tool. Always `custom`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The tool invocation context(s).
        sig { returns(T.nilable(T::Array[OpenAI::Responses::CustomTool::AllowedCaller::OrSymbol])) }
        attr_accessor :allowed_callers

        # Whether the tool response can be returned asynchronously versus immediately
        # returned on next response creation.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :async

        sig { params(async: T::Boolean).void }
        attr_writer :async

        # Whether this tool should be deferred and discovered via tool search.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :defer_loading

        sig { params(defer_loading: T::Boolean).void }
        attr_writer :defer_loading

        # Optional description of the custom tool, used to provide more context.
        sig { returns(T.nilable(String)) }
        attr_reader :description

        sig { params(description: String).void }
        attr_writer :description

        # The input format for the custom tool. Default is unconstrained text.
        sig { returns(T.nilable(T.any(OpenAI::CustomToolInputFormat::Text, OpenAI::CustomToolInputFormat::Grammar))) }
        attr_reader :format_

        sig {
          params(
            format_: T.any(OpenAI::CustomToolInputFormat::Text::OrHash, OpenAI::CustomToolInputFormat::Grammar::OrHash)
          )
            .void
        }
        attr_writer :format_

        # A custom tool that processes input using a specified format. Learn more about
        # [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
        sig do
          params(

            name: String,

            allowed_callers: T.nilable(T::Array[OpenAI::Responses::CustomTool::AllowedCaller::OrSymbol]),

            async: T::Boolean,

            defer_loading: T::Boolean,

            description: String,

            format_: T.any(OpenAI::CustomToolInputFormat::Text::OrHash, OpenAI::CustomToolInputFormat::Grammar::OrHash),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The name of the custom tool, used to identify it in tool calls.
          name:,

          # The tool invocation context(s).
          allowed_callers: nil,

          # Whether the tool response can be returned asynchronously versus immediately
          # returned on next response creation.
          async: nil,

          # Whether this tool should be deferred and discovered via tool search.
          defer_loading: nil,

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
              allowed_callers: T.nilable(T::Array[OpenAI::Responses::CustomTool::AllowedCaller::OrSymbol]),
              async: T::Boolean,
              defer_loading: T::Boolean,
              description: String,
              format_: T.any(OpenAI::CustomToolInputFormat::Text, OpenAI::CustomToolInputFormat::Grammar)
            }
          )
        end
        def to_hash
        end

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Responses::CustomTool::AllowedCaller) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DIRECT = T.let(:direct, OpenAI::Responses::CustomTool::AllowedCaller::TaggedSymbol)
          PROGRAMMATIC = T.let(:programmatic, OpenAI::Responses::CustomTool::AllowedCaller::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Responses::CustomTool::AllowedCaller::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
