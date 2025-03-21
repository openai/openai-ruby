# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDeltaBlock < OpenAI::BaseModel
          # The index of the content part in the message.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Always `text`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::TextDelta)) }
          def text
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::TextDelta, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::TextDelta, OpenAI::Util::AnyHash))
          end
          def text=(_)
          end

          # The text content that is part of a message.
          sig do
            params(
              index: Integer,
              text: T.any(OpenAI::Models::Beta::Threads::TextDelta, OpenAI::Util::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(index:, text: nil, type: :text)
          end

          sig { override.returns({index: Integer, type: Symbol, text: OpenAI::Models::Beta::Threads::TextDelta}) }
          def to_hash
          end
        end
      end
    end
  end
end
