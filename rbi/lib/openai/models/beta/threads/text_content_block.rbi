# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Text) }
          def text
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::Text, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Text, OpenAI::Util::AnyHash))
          end
          def text=(_)
          end

          # Always `text`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # The text content that is part of a message.
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
