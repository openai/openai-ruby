# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Text) }
          def text
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Text).returns(OpenAI::Models::Beta::Threads::Text) }
          def text=(_)
          end

          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { params(text: OpenAI::Models::Beta::Threads::Text, type: Symbol).returns(T.attached_class) }
          def self.new(text:, type: :text)
          end

          sig { override.returns({text: OpenAI::Models::Beta::Threads::Text, type: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
