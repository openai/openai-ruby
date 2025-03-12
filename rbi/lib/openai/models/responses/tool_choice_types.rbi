# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceTypes < OpenAI::BaseModel
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(type:)
        end

        sig { override.returns({type: Symbol}) }
        def to_hash
        end

        class Type < OpenAI::Enum
          abstract!

          FILE_SEARCH = :file_search
          WEB_SEARCH_PREVIEW = :web_search_preview
          COMPUTER_USE_PREVIEW = :computer_use_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
