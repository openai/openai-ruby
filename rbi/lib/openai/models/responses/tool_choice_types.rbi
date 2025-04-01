# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceTypes < OpenAI::BaseModel
        # The type of hosted tool the model should to use. Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        #   Allowed values are:
        #
        #   - `file_search`
        #   - `web_search_preview`
        #   - `computer_use_preview`
        sig { returns(OpenAI::Models::Responses::ToolChoiceTypes::Type::OrSymbol) }
        attr_accessor :type

        # Indicates that the model should use a built-in tool to generate a response.
        #   [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
        sig { params(type: OpenAI::Models::Responses::ToolChoiceTypes::Type::OrSymbol).returns(T.attached_class) }
        def self.new(type:)
        end

        sig { override.returns({type: OpenAI::Models::Responses::ToolChoiceTypes::Type::OrSymbol}) }
        def to_hash
        end

        # The type of hosted tool the model should to use. Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        #   Allowed values are:
        #
        #   - `file_search`
        #   - `web_search_preview`
        #   - `computer_use_preview`
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ToolChoiceTypes::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ToolChoiceTypes::Type::TaggedSymbol) }

          FILE_SEARCH = T.let(:file_search, OpenAI::Models::Responses::ToolChoiceTypes::Type::TaggedSymbol)
          WEB_SEARCH_PREVIEW =
            T.let(:web_search_preview, OpenAI::Models::Responses::ToolChoiceTypes::Type::TaggedSymbol)
          COMPUTER_USE_PREVIEW =
            T.let(:computer_use_preview, OpenAI::Models::Responses::ToolChoiceTypes::Type::TaggedSymbol)
          WEB_SEARCH_PREVIEW_2025_03_11 =
            T.let(:web_search_preview_2025_03_11, OpenAI::Models::Responses::ToolChoiceTypes::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ToolChoiceTypes::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
