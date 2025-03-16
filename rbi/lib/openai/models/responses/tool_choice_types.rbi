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
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Indicates that the model should use a built-in tool to generate a response.
        #   [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(type:)
        end

        sig { override.returns({type: Symbol}) }
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
        class Type < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          FILE_SEARCH = :file_search
          WEB_SEARCH_PREVIEW = :web_search_preview
          COMPUTER_USE_PREVIEW = :computer_use_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11
        end
      end
    end
  end
end
