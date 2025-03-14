# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlockParam < OpenAI::BaseModel
          # Text content to be sent to the model
          sig { returns(String) }
          def text
          end

          sig { params(_: String).returns(String) }
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
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(text:, type: :text)
          end

          sig { override.returns({text: String, type: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
