# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlockParam < OpenAI::BaseModel
          # Text content to be sent to the model
          sig { returns(String) }
          attr_accessor :text

          # Always `text`.
          sig { returns(Symbol) }
          attr_accessor :type

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
