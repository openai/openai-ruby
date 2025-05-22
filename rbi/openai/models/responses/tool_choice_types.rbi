# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceTypes < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ToolChoiceTypes, OpenAI::Internal::AnyHash)
          end

        # The type of hosted tool the model should to use. Learn more about
        # [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        # Allowed values are:
        #
        # - `file_search`
        # - `web_search_preview`
        # - `computer_use_preview`
        # - `code_interpreter`
        # - `mcp`
        # - `image_generation`
        sig { returns(OpenAI::Responses::ToolChoiceTypes::Type::OrSymbol) }
        attr_accessor :type

        # Indicates that the model should use a built-in tool to generate a response.
        # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
        sig do
          params(
            type: OpenAI::Responses::ToolChoiceTypes::Type::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The type of hosted tool the model should to use. Learn more about
          # [built-in tools](https://platform.openai.com/docs/guides/tools).
          #
          # Allowed values are:
          #
          # - `file_search`
          # - `web_search_preview`
          # - `computer_use_preview`
          # - `code_interpreter`
          # - `mcp`
          # - `image_generation`
          type:
        )
        end

        sig do
          override.returns(
            { type: OpenAI::Responses::ToolChoiceTypes::Type::OrSymbol }
          )
        end
        def to_hash
        end

        # The type of hosted tool the model should to use. Learn more about
        # [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        # Allowed values are:
        #
        # - `file_search`
        # - `web_search_preview`
        # - `computer_use_preview`
        # - `code_interpreter`
        # - `mcp`
        # - `image_generation`
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ToolChoiceTypes::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          FILE_SEARCH =
            T.let(
              :file_search,
              OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol
            )
          WEB_SEARCH_PREVIEW =
            T.let(
              :web_search_preview,
              OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW =
            T.let(
              :computer_use_preview,
              OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol
            )
          WEB_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :web_search_preview_2025_03_11,
              OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol
            )
          IMAGE_GENERATION =
            T.let(
              :image_generation,
              OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol
            )
          CODE_INTERPRETER =
            T.let(
              :code_interpreter,
              OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol
            )
          MCP =
            T.let(:mcp, OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ToolChoiceTypes::Type::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
