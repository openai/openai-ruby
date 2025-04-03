# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Text) }
          attr_reader :text

          sig { params(text: T.any(OpenAI::Models::Beta::Threads::Text, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :text

          # Always `text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The text content that is part of a message.
          sig do
            params(text: T.any(OpenAI::Models::Beta::Threads::Text, OpenAI::Internal::Util::AnyHash), type: Symbol)
              .returns(T.attached_class)
          end
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
